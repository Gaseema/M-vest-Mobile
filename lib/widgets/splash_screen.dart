import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({super.key});
  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isVisible = false;

  void checkFirstInstall(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasLoggedIn = prefs.getBool('hasLoggedIn') ?? true;

    if (hasLoggedIn) {
      await prefs.setBool('hasLoggedIn', false);
      // Navigate to the welcome page
      if (context.mounted) {
        context.go('/welcome');
      }
    } else {
      // Navigate to the pincode page
      if (context.mounted) {
        context.go('/welcome');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Start off-screen from the top
      end: const Offset(0.0, 0.0), // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Trigger animation after a delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
        _controller.forward();
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        checkFirstInstall(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0, // Set opacity based on visibility
          duration: const Duration(milliseconds: 1000), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          child: SlideTransition(
            position: _offsetAnimation,
            child: Image.asset(
              'assets/icons/mvest_light.png',
              width: 400,
            ),
          ),
        ),
      ),
    );
  }
}
