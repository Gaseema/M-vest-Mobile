// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for some time and then navigate to the home screen
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(36, 77, 97, 1.0),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: Image(
                image: AssetImage('assets/images/X_Logo.png'),
              ),
            ),
          ),
          Column(children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/splash_image.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
