import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// TODO: Simple login with mobile, google, & apple exclusively?
// (Or continue with basic username/password combo)

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("Login Box"),
          ),
          Container(
            child: Text("Login box"),
          ),
        ],
      ),
    );
  }
}