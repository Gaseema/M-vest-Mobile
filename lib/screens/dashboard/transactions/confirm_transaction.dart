import 'package:invest/imports/imports.dart';

import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/screens/dashboard/transactions/transaction_status.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../widgets/currency_converter.dart';

class ConfirmTransaction extends StatefulWidget {
  final String? transactionType;
  final String? transactionAmount;
  final int? walletID;
  final String? phoneNo;
  const ConfirmTransaction({
    Key? key,
    this.transactionType,
    this.transactionAmount,
    this.walletID,
    this.phoneNo,
  }) : super(key: key);

  @override
  ConfirmTransactionState createState() => ConfirmTransactionState();
}

class ConfirmTransactionState extends State<ConfirmTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          'Confirm Transaction',
          style: displayNormalBiggerSlightlyBoldBlack,
        ),
        Container(width: 30),
      ],
    );
    Widget transactionDetails = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Okay, let's review.",
            style: displayNormalBoldBlack,
          ),
          const SizedBox(height: 10),
          Text(
            'Confirm the details below to complete the transaction',
            style: displayNormalBlack,
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromRGBO(246, 246, 246, 1),
                        ),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'M-Pesa ${capitalizeString(widget.transactionType)}',
                          style: displaySmallBoldLightGrey,
                        ),
                        Text(
                          'Fee: KES 0',
                          style: displayNormalBlack,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Text(
                              'AMOUNT IN KES',
                              style: displaySmallBoldLightGrey,
                            ),
                          ),
                          Text(
                            CurrencyConverter()
                                .convert(widget.transactionAmount.toString()),
                            style: displayNormalBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              topAppBar,
              transactionDetails,
              Expanded(child: Container()),
              CustomButton(
                url: widget.transactionType == 'deposit'
                    ? '/transaction/deposit/mpesa'
                    : '/transaction/mpesa/withdraw',
                method: 'POST',
                text: 'Confirm',
                body: {
                  'transaction_type': widget.transactionType,
                  'amount': int.tryParse(widget.transactionAmount!
                          .replaceAll(RegExp(r'[^0-9]'), '')) ??
                      0,
                  //             0,
                  //widget.transactionAmount,
                  //  int.tryParse(targetAmount.text
                  //                 .replaceAll(RegExp(r'[^0-9]'), '')) ??
                  //             0,

                  'plan_id': widget.walletID,
                  'phone_number': widget.phoneNo,
                },
                onCompleted: (res) {
                  if (res['isSuccessful'] == true) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: TransactionStatus(
                        transactionType: widget.transactionType,
                        transactionAmount: widget.transactionAmount,
                        transactionData: res['data'],
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
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
