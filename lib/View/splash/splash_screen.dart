import 'dart:async';
import 'package:chat_app/View/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
    return Image.asset(
      'assets/images/splash.png',
      fit: BoxFit.fill,
    );
  }
}
