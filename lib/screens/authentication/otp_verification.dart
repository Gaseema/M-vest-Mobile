// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:invest/screens/authentication/reset_password.dart';

import '../../utils/theme.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:invest/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OTPVerification extends StatefulWidget {
  final String? otp;
  final String? email;
  const OTPVerification({super.key, this.otp, this.email});

  static const int countdownSeconds = 60;

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  static const int countdownSeconds = 120;
  late Timer _countdownTimer;
  int _secondsRemaining = countdownSeconds;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _countdownTimer.cancel();
        }
      });
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'OTP verification',
                style: displayNormalBolderDarkBlueHeading,
              ),
              SizedBox(height: 8),
              Text(
                'We sent a verification code to your email',
                style: displayNormalBlack,
              ),
              SizedBox(height: 24),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/otp.png'),
                ),
              ),
              SizedBox(
                height: 43,
              ),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                // onSubmit: (String verificationCode) {
                //   showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           title: Text("Verification Code"),
                //           content: Text('Code entered is $verificationCode'),
                //         );
                //       });
                // }, // end onSubmit
                onSubmit: (String verificationCode) {
                  if (verificationCode.length == 4) {
                    // All OTP fields are filled
                    // Proceed to reset password page or perform desired action

                    if (widget.otp != verificationCode) {
                      showToast(
                        context,
                        'Error!',
                        'Enter a valid OTP',
                        Colors.red,
                      );
                    } else {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ResetPassword(email: widget.email),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    }
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  '${formatTime(_secondsRemaining)} Sec',
                  style: displayNormalBlack,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Did you get a verification code? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Send again',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle Terms of Use tap
                            //  print('Create now tapped');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignUp()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
