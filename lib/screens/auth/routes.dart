import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/auth/forgot_password.dart';
import 'package:onthegrubv2/screens/auth/login.dart';
import 'package:onthegrubv2/screens/auth/registration/user_registration.dart';
import 'package:onthegrubv2/screens/auth/splash_screen.dart';

class AuthScreenRoutes {
  static Map<String, WidgetBuilder> routes = {
    ForgotPassword.routeName: (BuildContext context) => ForgotPassword(),
    LoginScreen.routeName: (BuildContext context) => LoginScreen(),
    SplashScreen.routeName: (BuildContext context) => SplashScreen(),
    Registration.routeName: (BuildContext context) => Registration(),
  };
}
