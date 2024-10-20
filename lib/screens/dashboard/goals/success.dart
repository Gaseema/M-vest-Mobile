import 'package:invest/imports/imports.dart';

// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:invest/screens/dashboard/dashboard.dart';
import 'package:invest/utils/constants.dart';

import '../../../utils/theme.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../widgets/currency_converter.dart';

// import 'home_button.dart';

class Success extends StatefulWidget {
  final String? goalName;
  final String? description;
  final num? targetAmount;
  final String? category;
  final String? maturityDate;
  final bool? locked;
  final String? frequency;
  final num? planId;
  final String? screen;
  final List? membersList;
  const Success(
      {Key? key,
      required this.category,
      this.description,
      this.goalName,
      this.locked,
      this.maturityDate,
      this.targetAmount,
      this.frequency,
      this.planId,
      this.screen,
      required this.membersList})
      : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

//Color themeColor = const Color(0xFF43D19E);

class _SuccessState extends State<Success> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 170,
                  padding: EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    //color: primaryDarkColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/icons/success.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    child: Text('${widget.screen}'),
                    // Text(
                    //   "Congratulations! Your plan has been successfully created.",
                    //   textAlign: TextAlign.center,
                    //   style: displayNormalBlack,
                    // ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                Text(
                  "Target",
                  style: displaySmallThinBlack,
                ),
                SizedBox(height: 5),
                Text(
                  CurrencyConverter().convert(widget.targetAmount.toString()),
                  style: TextStyle(
                    color: primaryDarkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  widget.goalName!,
                  // widget.goalName}",
                  style: displayNormalLightGrey,
                ),
                SizedBox(height: screenHeight * 0.05),
                SizedBox(height: screenHeight * 0.06),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const Dashboard(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Confirmed',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
