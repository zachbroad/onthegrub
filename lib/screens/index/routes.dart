import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/index/index_screen.dart';

class IndexScreenRoutes {
  static Map<String, WidgetBuilder> routes = {
    IndexScreen.routeName: (BuildContext context) => IndexScreen(),
  };
}
