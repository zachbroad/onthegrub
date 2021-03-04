import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/splash.dart';

class Routes {
  static Map<String, WidgetBuilder> all() {
    return {
      SplashScreen.routeName: (BuildContext context) => SplashScreen(),
    };
  }
}
