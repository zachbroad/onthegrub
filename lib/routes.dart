import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/auth/routes.dart';
import 'package:onthegrubv2/screens/index/routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all() {
    Map<String, WidgetBuilder> all = {};
    all.addAll(AuthScreenRoutes.routes);
    all.addAll(IndexScreenRoutes.routes);
    return all;
  }
}
