import 'package:flutter/material.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import '../login/screens/login.dart';
import 'forgot_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                      onTap: () => AppRouter.router.navigateTo(context, Routes.login),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
