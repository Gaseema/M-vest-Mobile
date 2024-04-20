import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/dashboard.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/widgets/animations.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';

class TransactionStatus extends StatefulWidget {
  final String? transactionType;
  final String? transactionAmount;
  final Map? transactionData;
  final num? amount;
  const TransactionStatus({
    Key? key,
    this.transactionType,
    this.transactionAmount,
    this.transactionData,
    this.amount,
  }) : super(key: key);

  @override
  TransactionStatusState createState() => TransactionStatusState();
}

class TransactionStatusState extends State<TransactionStatus> {
  Timer? _timer;

  bool transactionIsPending = true;
  bool transactionIsIncomplete = false;

  fetchTransactionStatus() async {
    var userTransactionData = widget.transactionData;
    // Retrieve user information from provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    final postData = {
      "transaction_reference_number": userTransactionData?['reference_number'],
      "request_id": userTransactionData?['request_id'],
      "account_number": userTransactionData?['account_number'],
      "amount": widget.transactionAmount,
    };
    // final apiClient = ApiClient();
    // final headers = {
    //   'Authorization': 'Bearer $token',
    //   'Content-Type': 'application/json',
    // };

    // try {
    //   final response = await apiClient.post(
    //     '/transaction/payment_status/mpesa',
    //     postData,
    //     headers: headers,
    //   );
    //   //  print(response);

    //   return response;
    // } catch (error) {
    //   // Handle the error
    //   // print('error');
    //   // print(error);
    //   return null;
    // }
  }

  bool stopConditionMet = false;
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (stopConditionMet) {
        timer.cancel();
      } else {
        var theResponse = await fetchTransactionStatus();
        var status = theResponse['status'];
        if (status == 'complete') {
          setState(() {
            transactionIsPending = false;
            stopConditionMet = true;
          });
        } else if (status == 'error') {
          setState(() {
            transactionIsPending = false;
            transactionIsIncomplete = true;
            stopConditionMet = true;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;
    Widget transactionIncomplete = Column(
      children: [
        Text(
          "Transaction Incomplete",
          style: displayNormalBoldBlack,
        ),
        const SizedBox(height: 10),
        Text(
          'The payment of KES ${widget.transactionAmount} was not successfully processed. Please try again',
          style: displayNormalBlack,
          textAlign: TextAlign.center,
        ),
      ],
    );
    Widget transactionPendingInfo = Column(
      children: [
        Text(
          "Transaction Pending",
          style: displayNormalBoldBlack,
        ),
        const SizedBox(height: 10),
        Text(
          'You will receive a prompt from M-PESA to confirm payment of KES. ${widget.transactionAmount}. Enter your MPESA password to deposit to your plan',
          style: displayNormalBlack,
          textAlign: TextAlign.center,
        ),
      ],
    );
    Widget transactionCompleteInfo = Column(
      children: [
        Text(
          "Transaction Complete",
          style: displayNormalBoldBlack,
        ),
        const SizedBox(height: 10),
        Text(
          'You have successfully deposited KES ${widget.transactionAmount} to you plan.',
          style: displayNormalBlack,
          textAlign: TextAlign.center,
        ),
      ],
    );
    Widget transactionPending = Column(
      children: [
        const SizedBox(height: 50),
        transactionIsPending == true
            ? const StaggeredDotsWave(
                size: 100,
                color: primaryDarkColor,
              )
            : transactionIsIncomplete == true
                ? const AnimatedCheckFailed()
                : const AnimatedCheckSuccess(),
        const SizedBox(height: 20),
        transactionIsPending == true
            ? transactionPendingInfo
            : transactionIsIncomplete == true
                ? transactionIncomplete
                : transactionCompleteInfo,
      ],
    );
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                transactionPending,
                Expanded(child: Container()),
                CustomButton(
                  url: null,
                  method: 'POST',
                  text: 'Complete',
                  body: const {},
                  onCompleted: (res) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const Dashboard(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
