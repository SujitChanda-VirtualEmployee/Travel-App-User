import 'package:flutter/material.dart';
import 'package:travel_app_user/screens/onboarding_screen.dart';
import 'package:travel_app_user/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, OnboardingScreen.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SizedBox(
        height: SizeConfig.fullHeight,
        width: SizeConfig.fullWidth,
        child: Center(
          child: Image.asset(
            "images/splash_logo.png",
            width: SizeConfig.fullWidth / 1.5,
          ),
        ),
      ),
    );
  }
}
