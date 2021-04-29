import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String index = "/index/";
  static String login = "/login/";
  static String registration = "/registration/";
  static String forgotPassword = "/forgot_password/";
  static String splashScreen = "/";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return SafeArea(child: Text("Route not found! [${router.toString()}]"));
    });
    router.define(splashScreen, handler: splashScreenHandler);
    router.define(registration, handler: registrationHandler);
    router.define(login, handler: loginHandler);
    router.define(forgotPassword, handler: forgotPasswordHandler);
    router.define(index + ":initialRoute", handler: indexHandler);
  }
}
