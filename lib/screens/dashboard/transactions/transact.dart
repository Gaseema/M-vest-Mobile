import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';

import 'package:invest/utils/theme.dart';
import 'package:invest/widgets/keypad.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/screens/dashboard/transactions/confirm_transaction.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../widgets/currency_converter.dart';

class MakeTransaction extends StatefulWidget {
  final String? transactionType;
  final int? walletID;
  final String? category;
  final num? planBalance;
  final String? phoneNo;
  const MakeTransaction({
    Key? key,
    this.transactionType,
    this.walletID,
    this.category,
    this.planBalance,
    this.phoneNo,
  }) : super(key: key);

  @override
  MakeTransactionState createState() => MakeTransactionState();
}

class MakeTransactionState extends State<MakeTransaction> {
  bool buttonError = true;
  String buttonErrorMessage = 'Enter amount greater than KES 1';
  String amountText = '0';

  String phoneNumber = '';
  TextEditingController phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    // Modify the phoneField widget to show the text before the phone number.
    Widget phoneField = _isEditing
        ? Column(children: [
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                labelText: 'Edit Phone Number',
                floatingLabelAlignment: FloatingLabelAlignment.center,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                // You can add more validation as needed...
                return null;
              },
            ),
            const SizedBox(height: 12),
          ])
        : GestureDetector(
            onTap: () {
              setState(() {
                _isEditing = true;
                phoneController.text = user.phoneNo; // Set initial value
              });
            },
            child: Column(
              children: [
                Text(
                  'Phone number to deposit from',
                  style: displayNormalBlack,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(user!.phoneNo),
                    const SizedBox(width: 20),
                    Text(
                      'Edit phone number', // Display the phone number
                      style: displayNormalBolderDarkBlue,
                    ),
                  ],
                ),
              ],
            ),
          );
    Widget saveButton = _isEditing
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Save the changes to user.phoneNo here
                // setState(() {
                //   user!.phoneNo = phoneController.text;
                //   _isEditing = false;
                // });
              },
              child: const Text('Confirm'),
            ),
          )
        : const SizedBox.shrink();

    Widget topAppBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icons/back.png',
            width: 30,
          ),
        ),
        Text(
          capitalizeString(widget.transactionType),
          style: displayNormalBiggerSlightlyBoldBlack,
        ),
        Container(width: 30),
      ],
    );
    // Button-like component with small 10 dots

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              topAppBar,
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                      decoration: BoxDecoration(
                        color: secondaryGoldColorDarker,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${widget.category}',
                        style: displaySmallWhite,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: AutoSizeText(
                        CurrencyConverter().convert(amountText),
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 15,
                        ),
                        minFontSize: 15,
                        maxLines: 1,
                        maxFontSize: 25,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (widget.transactionType ==
                        'withdraw') // If transaction type is 'withdraw'

                      Text(
                        // CurrencyConverter().convert(widget.planBalance.toString())
                        'Your wallet balance is: ${CurrencyConverter().convert(widget.planBalance.toString())}',
                        style: displaySmallThinBlack,
                      ),
                    if (widget.transactionType == 'deposit') phoneField,
                    saveButton,
                    // Text(
                    //   // CurrencyConverter().convert(widget.planBalance.toString())
                    //   'Select number to deposit from ${user!.phoneNo}',
                    //   style: displaySmallThinBlack,
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: CustomButton(
                    url: null,
                    method: 'POST',
                    text: 'Continue',
                    body: const {},
                    onCompleted: (res) {
                      if (widget.transactionType == 'withdraw' &&
                          widget.planBalance != null &&
                          widget.planBalance! < num.parse(amountText)) {
                        showToast(
                          context,
                          'Error!',
                          'Insufficient balance in your wallet.',
                          Colors.red,
                        );
                      } else if (amountText == '0') {
                        // Display an error if amountText is null or 0
                        showToast(
                          context,
                          'Error!',
                          'Please enter the amount you want to deposit.',
                          Colors.red,
                        );
                      } else if (res['isSuccessful'] == true) {
                        if (res['isSuccessful'] == true) {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ConfirmTransaction(
                              transactionType: widget.transactionType,
                              transactionAmount: amountText,
                              walletID: widget.walletID,
                              phoneNo: widget.phoneNo,
                            ),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        } else {
                          showToast(
                            context,
                            'Error!',
                            res['error'],
                            Colors.red,
                          );
                        }
                      }
                    }),
              ),
              Keypad(
                dot: true,
                callback: (val) {
                  setState(() {
                    buttonError = false;
                    if (val == '<') {
                      if (amountText.isNotEmpty) {
                        amountText = amountText.substring(
                          0,
                          amountText.length - 1,
                        );
                        if (amountText.isEmpty) {
                          amountText = '0';
                          setState(() {
                            buttonError = true;
                          });
                        }
                      }
                    } else if (val == '.') {
                      if (!amountText.contains('.')) {
                        amountText = '$amountText.';
                      }
                    } else {
                      if (amountText == '0') {
                        amountText = '$val';
                      } else {
                        amountText = '$amountText$val';
                      }
                    }
                    if (num.parse(amountText) < 1) {
                      buttonError = true;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
