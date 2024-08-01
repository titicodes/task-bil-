import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/UI/on-boarding/nav.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../constants/reuseables.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splash: Image.asset(
            AppImages.appLogo,
            fit: BoxFit.fill,
          ),
          splashTransition: SplashTransition.fadeTransition,
          curve: Curves.easeIn,
          duration: 4000,
          splashIconSize: (width(context) - 50),
          animationDuration: const Duration(seconds: 2),
          backgroundColor: Colors.white,
          nextScreen: const NavScreen()),
    );
  }
}
