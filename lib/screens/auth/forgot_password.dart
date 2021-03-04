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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                child: Image.asset(
                  "assets/grubtruck.png",
                  width: MediaQuery.of(context).size.width * .35,
                  height: MediaQuery.of(context).size.height * .275,
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Padding(
                padding: EdgeInsets.only(left: 22, right: 22, top: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "FORGOT PASSWORD?",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: double.infinity,
                      //height: ScreenUtil.getInstance().setHeight(300),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Theme.of(context).dividerColor),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).dividerColor,
                              offset: Offset(-2.0, 15.0),
                              blurRadius: 8.0,
                            ),
                            BoxShadow(
                              color: Theme.of(context).dividerColor,
                              offset: Offset(2.0, -10.0),
                              blurRadius: 8.0,
                            ),
                          ]),
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
                          child: Text('Want to log in instead? Click here.', style: TextStyle(color: Colors.black.withAlpha(160))),
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
        ],
      ),
    );
  }
}
