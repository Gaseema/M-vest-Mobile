import 'package:flutter/material.dart';
import 'package:invest/widgets/pin_code_field.dart';
import 'package:invest/widgets/appbar.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:invest/widgets/keypad.dart';
import 'package:invest/utils/api.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  static const int countdownSeconds = 60;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  static const int countdownSeconds = 120;
  late Timer _countdownTimer;
  int _secondsRemaining = countdownSeconds;

  List<bool> processingStates = List.filled(4, false);
  String codeValue = '';
  bool pincodeError = false;
  late Timer timer;

  void startProcessing() {
    const interval = Duration(milliseconds: 120);
    int count = 0;

    timer = Timer.periodic(interval, (Timer t) {
      setState(() {
        processingStates[count % 4] = !processingStates[count % 4];
        count++;
      });
    });
  }

  void stopProcessing() {
    timer.cancel();
    setState(() {
      processingStates = List.filled(4, false);
    });
  }

  void pinError() {
    setState(() {
      pincodeError = true;
    });
    stopProcessing();
  }

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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                title: '',
                actions: const [],
                leadingOnTap: () {
                  context.pop();
                },
                statusBarBrightness: Brightness.light,
              ),
              const SizedBox(height: 50),
              Text(
                "Verify Email.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 30,
                    ),
              ),
              Text(
                "We have sent an OTP request to your email address ${widget.email}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              Expanded(child: Container()),
              Center(
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return PinCodeField(
                        processing: processingStates[index],
                        filled: codeValue.length >= index + 1,
                        hasError: pincodeError,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                pincodeError ? 'Oops! Wrong OTP code' : '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Resend: ${formatTime(_secondsRemaining)}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
              const SizedBox(height: 20),
              Keypad(
                callback: (value) {
                  setState(() {
                    if (value == '<' && codeValue.isNotEmpty) {
                      codeValue = codeValue.substring(0, codeValue.length - 1);
                      pincodeError = false;
                      stopProcessing();
                    } else if (codeValue.length < 4 && value != '.') {
                      if (value == '<') return;
                      codeValue += value;
                      if (codeValue.length == 4) {
                        startProcessing();
                        apiCall(
                          'POST',
                          '/user/verify/email_otp',
                          {'email': widget.email, 'otp': codeValue},
                        ).then((res) {
                          if (res['isSuccessful'] == true) {
                            context.go('/register', extra: widget.email);
                          } else {
                            pinError();
                          }
                        });
                      }
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
