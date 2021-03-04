import 'package:flutter/material.dart';
import 'package:onthegrubv2/models/user.dart';
import 'package:onthegrubv2/screens/auth/forgot_password.dart';
import 'package:provider/provider.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // User user = Provider.of<User>(context, listen: false);
    // if (user == null) user = User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<User>(builder: (context, user, child) {
      Color textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(.9) : Colors.black.withOpacity(.9);
      Color loginCardColor = Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(.3) : Colors.white.withOpacity(.3);

      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: Image.asset("assets/bgmap.jpg").image, fit: BoxFit.fitHeight),
          gradient: LinearGradient(
            colors: [theme.colorScheme.primaryVariant, theme.colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                  child: ListView(
                children: [
                  Card(
                    color: loginCardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Image.asset("assets/grubtruck.png", width: 96, height: 96),
                        Text("OnTheGrub", style: theme.textTheme.headline2.copyWith(color: textColor)),
                        LoginForm(),
                        SizedBox(height: 16.0),
                        Center(
                          child: GestureDetector(
                            child: Text('Forgot password?', style: TextStyle(color: textColor)),
                            onTap: () => Navigator.pushNamed(context, ForgotPassword.routeName),
                          ),
                        ),
                        SizedBox(height: 16),
//                        Padding(
//                          padding: const EdgeInsets.all(16.0),
//                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                            Text(
//                              "Support",
//                              style: TextStyle(color: textColor),
//                            ),
//                            Text(
//                              "Website",
//                              style: TextStyle(
//                                color: textColor,
//                              ),
//                            ),
//                          ]),
//                        )
                      ],
                    ),
                  ),
                ],
              )),
            )),
      );
    });
  }
}
