import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/screens/index/index_screen.dart';
import 'package:onthegrubv2/screens/trucks.dart';

class IndexScreenRoutes {
  static Map<String, WidgetBuilder> routes = {
    IndexScreen.routeName: (BuildContext context) => IndexScreen(),
    TrucksList.routeName: (BuildContext context) => TrucksList(),
  };
}
