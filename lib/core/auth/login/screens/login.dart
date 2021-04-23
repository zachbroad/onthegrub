import 'package:flutter/material.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/constants/assets_path.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';
import 'package:provider/provider.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);
    if (user == null) user = User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<User>(builder: (context, user, child) {
      Color loginCardColor = Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(.3) : Colors.white.withOpacity(.3);

      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: Image.asset(Assets.bgmap).image, fit: BoxFit.fitHeight),
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
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 36, horizontal: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),

                        Image.asset(Assets.grubtruck, width: 96, height: 96),
                        Text(
                          "OnTheGrub",
                          style: theme.textTheme.headline4,
                        ),
                        SizedBox(height: 8.0),

                        LoginForm(),
                        SizedBox(height: 16.0),

                        Center(
                          child: GestureDetector(
                            child: Text('Forgot password?'),
                            onTap: () => AppRouter.router.navigateTo(context, Routes.forgotPassword),
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
