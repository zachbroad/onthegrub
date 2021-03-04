import 'package:flutter/material.dart';

/* TODO:
  - Check to see if user was previously logged in
    If yes:
      Send user to their home screen
    If no:
      Send user to login screen
*/

class SplashScreen extends StatefulWidget {
  static final String routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
          ),
        ),
      ),
    );
  }
}
