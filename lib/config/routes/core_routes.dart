import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/core/auth/forgot_password/forgot_password.dart';
import 'package:onthegrubv2/core/auth/login/screens/login.dart';
import 'package:onthegrubv2/core/auth/registration/screens/user_registration.dart';
import 'package:onthegrubv2/core/auth/splash_screen.dart';

class CoreRoutes {
  static Map<String, WidgetBuilder> routes = {
    ForgotPassword.routeName: (BuildContext context) => ForgotPassword(),
    LoginScreen.routeName: (BuildContext context) => LoginScreen(),
    SplashScreen.routeName: (BuildContext context) => SplashScreen(),
    Registration.routeName: (BuildContext context) => Registration(),
  };
}
