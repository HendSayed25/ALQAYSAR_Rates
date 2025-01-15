import 'package:alqaysar_rates/core/config/routes/route_constants.dart';
import 'package:alqaysar_rates/core/helper/extensions.dart';
import 'package:alqaysar_rates/core/resource/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/image_animation.dart';
import 'widgets/text_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late Animation<Offset> _imageAnimation;
  late Animation<double> _text1Opacity;
  late Animation<double> _text2Opacity;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _imageAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _imageController, curve: Curves.easeInOut));

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _text1Opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.2, 0.5)),
    );
    _text2Opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.5, 0.8)),
    );

    _imageController.forward();

    Future.delayed(const Duration(milliseconds: 1250), () {
      _textController.forward();
    });

    // After the animation finishes, navigate to the LoginScreen
    Future.delayed(const Duration(milliseconds: 2500), () {
      context.pushNamed(Routes.loginScreenRoute);
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColor[0], // Start color
              AppColors.backgroundColor[1], // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              ImageAnimation(imageAnimation: _imageAnimation),
              Positioned(
                right: 55.w,
                top: 0.5.sh - 40.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextAnimation(
                      text1Opacity: _text1Opacity,
                      text: 'القيصر',
                      textSize: 48,
                    ),
                    TextAnimation(
                      text1Opacity: _text2Opacity,
                      text: 'ALQAYSAR',
                      textSize: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


