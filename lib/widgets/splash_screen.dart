import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isVisible = false;

  Future<void> _preloadImage() async {
    final image = AssetImage('assets/illustrations/welcome.jpg');
    await precacheImage(image, context);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
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
        // Navigate after the animation is completed and the image is preloaded
        if (mounted) {
          context.go('/welcome');
        }
      });
    });

    // Preload the image
    _preloadImage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
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
