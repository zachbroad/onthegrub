import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/config/routes/core_routes.dart';
import 'package:onthegrubv2/config/routes/index_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all() {
    Map<String, WidgetBuilder> all = {};
    all.addAll(CoreRoutes.routes);
    all.addAll(IndexRoutes.routes);
    return all;
  }
}
