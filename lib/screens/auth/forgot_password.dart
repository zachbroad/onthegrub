import 'package:flutter/material.dart';
import 'login.dart';
import 'widgets/forgot_password_form.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot_password';
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.only(left: 22, right: 22, top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Forgot your password?\nNo problem... we're on the way.",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 0,
                    ),
                    child: Column(
                      children: <Widget>[
                        ForgotPasswordForm(),
                      ],
                    ),
                  ),
                ),

                // Login Link
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: GestureDetector(
                      child: Text('Want to log in instead? Click here.'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        LoginScreen.routeName,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
