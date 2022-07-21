import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_user/screens/about_us_screen.dart';
import 'package:travel_app_user/screens/add_card_screen.dart';
import 'package:travel_app_user/screens/change_password_screen.dart';
import 'package:travel_app_user/screens/contact_us_screen.dart';
import 'package:travel_app_user/screens/forgot_password_screen.dart';
import 'package:travel_app_user/screens/history_screen.dart';
import 'package:travel_app_user/screens/home_screen/home_screen.dart';
import 'package:travel_app_user/screens/landing_screen.dart';
import 'package:travel_app_user/screens/location_permission_screen.dart';
import 'package:travel_app_user/screens/login_screen.dart';
import 'package:travel_app_user/screens/my_profile.dart';
import 'package:travel_app_user/screens/onboarding_screen.dart';
import 'package:travel_app_user/screens/otp_verification_screen.dart';
import 'package:travel_app_user/screens/peyment_method_screen.dart';
import 'package:travel_app_user/screens/rating_screen.dart';
import 'package:travel_app_user/screens/reset_password_screen.dart';
import 'package:travel_app_user/screens/settings_screen.dart';
import 'package:travel_app_user/screens/signup_screen.dart';
import 'package:travel_app_user/screens/splash_screen.dart';
import 'package:travel_app_user/screens/update_profile_screen.dart';
import '../screens/notification_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(
    RouteSettings settings,
  ) {
    final args = settings.arguments;
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case OnboardingScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const OnboardingScreen());
      case LoginScreen.id:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());
      case SignupScreen.id:
        return CupertinoPageRoute(builder: (context) => const SignupScreen());
      case ForgotPasswordScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const ForgotPasswordScreen());
      case OtpVerificationScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const OtpVerificationScreen());
      case ResetPasswordScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const ResetPasswordScreen());
      case LocationPermissionScreen.id:
        if (args is List<String>) {
          return CupertinoPageRoute(
              builder: (context) => LocationPermissionScreen(
                    title: args[0],
                    body: args[1],
                  ));
        }
        return _errorRoutes();
      case LandingScreen.id:
        return CupertinoPageRoute(builder: (context) => const LandingScreen());

      case SettingsScreen.id:
        return CupertinoPageRoute(builder: (context) => const SettingsScreen());
      case HistoryScreen.id:
        return CupertinoPageRoute(builder: (context) => const HistoryScreen());
      case NotificationScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const NotificationScreen());
      case ChangePasswordScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const ChangePasswordScreen());
      case RatingScreen.id:
        return CupertinoPageRoute(builder: (context) => const RatingScreen());
      case ContactUsScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const ContactUsScreen());
      case AboutUsScreen.id:
        return CupertinoPageRoute(builder: (context) => const AboutUsScreen());
      case MyProfileScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const MyProfileScreen());
      case UpdateProfileScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const UpdateProfileScreen());
      case PaymentMethodScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const PaymentMethodScreen());
      case AddNewCardScreen.id:
        return CupertinoPageRoute(
            builder: (context) => const AddNewCardScreen());
      default:
        return _errorRoutes();
    }
  }

  static Route<dynamic> _errorRoutes() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found!")),
      );
    });
  }
}
