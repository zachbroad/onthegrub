import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:onthegrubv2/core/auth/forgot_password/forgot_password.dart';
import 'package:onthegrubv2/core/auth/login/screens/login.dart';
import 'package:onthegrubv2/core/auth/registration/screens/user_registration.dart';
import 'package:onthegrubv2/core/auth/screens/splash_screen.dart';
import 'package:onthegrubv2/modules/index/index.dart';

// Core handlers
var loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var registrationHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegistrationScreen();
});

var forgotPasswordHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgotPasswordScreen();
});

var splashScreenHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SplashScreen();
});

// Module handlers
// Index handlers
var indexHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    switch (params["initialRoute"]?.first) {
      case "0":
        return IndexScreen(
          initialPage: 0,
        );
      case "1":
        return IndexScreen(
          initialPage: 1,
        );
      case "2":
        return IndexScreen(
          initialPage: 2,
        );
      case "3":
        return IndexScreen(
          initialPage: 3,
        );
      case "4":
        return IndexScreen(
          initialPage: 4,
        );
      default:
        return IndexScreen();
    }
  },
);
