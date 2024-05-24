import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/widgets/buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Image? image1;

  @override
  void initState() {
    super.initState();

    image1 = Image.asset(
      "assets/illustrations/welcome.jpg",
      fit: BoxFit.fitHeight,
      height: double.infinity,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        onPopInvoked: (intent) async {
          print('add a dialog to');
        },
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/illustrations/welcome.jpg',
                    fit: BoxFit.fitHeight,
                    height: double.infinity,
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(1),
                          Colors.white.withOpacity(1),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/mvest_primary.png',
                        width: 400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Put your',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 42,
                          color: darkHeaderColor,
                          height: 1,
                        ),
                  ),
                  Text(
                    'money to work',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 42,
                          color: darkHeaderColor,
                          height: 1,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Invest, save and grow wealth.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: darkHeaderColor,
                        ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    url: null,
                    method: '',
                    body: const {},
                    filled: false,
                    text: 'Continue with Google',
                    onCompleted: (val) {
                      print('gmail');
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    url: null,
                    method: '',
                    body: const {},
                    text: 'Continue with email',
                    onCompleted: (val) {
                      context.push('/email');
                    },
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
