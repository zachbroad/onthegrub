import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/src/elements/BlockButtonWidget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(29.5),
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 120,
            child: Container(
              width: config.App(context).appWidth(84),
              height: config.App(context).appHeight(29.5),
              child: Text(
                'Let\'s Start with register!',
                style: Theme.of(context).textTheme.display3.merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
              width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Miral Mia',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'miralia@gmail.com',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: '••••••••••••',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                      suffixIcon: Icon(Icons.remove_red_eye, color: Theme.of(context).focusColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  BlockButtonWidget(
                    text: Text(
                      'Register',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/MobileVerification');
                    },
                  ),
                  SizedBox(height: 25),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/MobileVerification');
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor.withOpacity(0.1),
                    shape: StadiumBorder(),
                    child: Text(
                      'Register with Google',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Login');
              },
              textColor: Theme.of(context).hintColor,
              child: Text('I have account? Back to login'),
            ),
          )
        ],
      ),
    );
  }
}
