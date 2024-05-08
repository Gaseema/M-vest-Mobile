import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/widgets/keypad.dart';
import 'dart:async';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  @override
  State<PinCodePage> createState() => PinCodePageState();
}

class PinCodePageState extends State<PinCodePage> {
  String codeValue = '';
  bool pincodeError = false;
  late Timer timer;
  List<bool> processingStates = List.filled(4, false);

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text(
                'Enter your PIN',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              SizedBox(
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
              const SizedBox(height: 20),
              Text(
                pincodeError ? 'Oops! Wrong PIN' : '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  pinError();
                },
                child: Text('Stop processing'),
              ),
              Keypad(
                actionButton: const Icon(Icons.fingerprint_rounded, size: 30),
                callback: (value) {
                  setState(() {
                    if (value == '<' && codeValue.isNotEmpty) {
                      codeValue = codeValue.substring(0, codeValue.length - 1);
                      pincodeError = false;
                    } else if (codeValue.length < 4 && value != '.') {
                      codeValue += value;
                      if (codeValue.length == 4) {
                        startProcessing();
                      }
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Forgot your pin?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: primaryColor,
                        decorationColor: primaryColor,
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

class PinCodeField extends StatelessWidget {
  final bool filled;
  final bool hasError;
  final bool processing;

  const PinCodeField({
    Key? key,
    required this.filled,
    required this.hasError,
    required this.processing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: filled ? 2 : 1,
          color: (hasError
              ? Colors.red
              : filled
                  ? primaryColor
                  : primaryColor.withOpacity(0.6)),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: processing
            ? [
                BoxShadow(
                  color: primaryColor,
                  spreadRadius: 1,
                  blurRadius: 8,
                )
              ]
            : [],
      ),
      child: Center(
        child: filled
            ? SvgPicture.asset(
                'assets/svg/asterisk.svg',
                width: 20,
                colorFilter: ColorFilter.mode(
                  hasError ? Colors.red : primaryColor,
                  BlendMode.srcIn,
                ),
              )
            : Container(),
      ),
    );
  }
}
