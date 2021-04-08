import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/modules/index/index.dart';
import 'package:onthegrubv2/modules/index/search/screens/trucks.dart';

class IndexRoutes {
  static Map<String, WidgetBuilder> routes = {
    IndexScreen.routeName: (BuildContext context) => IndexScreen(),
    TrucksList.routeName: (BuildContext context) => TrucksList(),
  };
}
