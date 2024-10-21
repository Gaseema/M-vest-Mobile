import 'package:invest/imports/imports.dart';

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
  String pincodeErrorMessage = '';
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

  void restartCountdown() {
    // Cancel any previous timers if running
    if (_countdownTimer.isActive) {
      _countdownTimer.cancel();
    }
    // Reset the countdown time
    setState(() {
      _secondsRemaining = countdownSeconds;
      codeValue = '';
      pincodeError = false;
      stopProcessing();
    });
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
  void initState() {
    super.initState();
    startCountdown();
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              Expanded(child: Container()),
              CustomText(
                text: "Verify Email.",
                style: displayLargeTextNormal(context),
              ),
              CustomRichText(
                textSpans: [
                  TextSpan(
                    text:
                        "Hey there! We've sent an OTP request to your email address ",
                    style: displayMediumTextNormal(context),
                  ),
                  TextSpan(
                    text: '${widget.email}. ',
                    style: displayMediumTextPrimaryBlue(context),
                  ),
                  TextSpan(
                    text:
                        "If you don't see it, be sure to check your spam folder—just in case!",
                    style: displayMediumTextNormal(context),
                  ),
                ],
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
              CustomText(
                text: pincodeError
                    ? pincodeErrorMessage.isNotEmpty
                        ? pincodeErrorMessage
                        : 'Oops! Error verifying OTP code'
                    : '',
                style: displayMediumTextRed(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  try {
                    if (_secondsRemaining == 0) {
                      resendEmailVerification(context, widget.email)
                          .then((res) {
                        logger(' res: resendEmailVerification');
                        logger(res);
                        if (res['isSuccessful'] == true) {
                          restartCountdown();
                          showToast(
                            context,
                            'Success',
                            'Verification OTP sent successfully',
                            primaryColor,
                          );
                        } else {
                          showToast(
                            context,
                            'Error!!!',
                            res['error'],
                            Colors.red,
                          );
                        }
                      });
                    }
                  } catch (err) {
                    showToast(
                      context,
                      'Error!!!',
                      'Error sending OTP code',
                      Colors.red,
                    );
                  }
                },
                child: CustomText(
                  text: _secondsRemaining == 0
                      ? 'Resend'
                      : 'Resend: ${formatTime(_secondsRemaining)}',
                  style: displayMediumTextNormal(context),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Keypad(
                callback: (value) {
                  setState(
                    () {
                      if (value == '<' && codeValue.isNotEmpty) {
                        codeValue =
                            codeValue.substring(0, codeValue.length - 1);
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
                            logger('<<<<<<<<user saved>>>>>>>>');
                            logger(res);
                            if (res['isSuccessful'] == true) {
                              context.push('/register',
                                  extra: res['data']['user']);
                            } else {
                              logger('<<<<<<<<<<verify email>>>>>>>>>>');
                              logger(res['error']);
                              pincodeErrorMessage = res['error'];
                              pinError();
                            }
                          });
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
