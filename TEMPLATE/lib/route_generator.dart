import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/pages/account.dart';
import 'package:restaurant_rlutter_ui/src/pages/cart.dart';
import 'package:restaurant_rlutter_ui/src/pages/chat.dart';
import 'package:restaurant_rlutter_ui/src/pages/checkout.dart';
import 'package:restaurant_rlutter_ui/src/pages/details.dart';
import 'package:restaurant_rlutter_ui/src/pages/food.dart';
import 'package:restaurant_rlutter_ui/src/pages/help.dart';
import 'package:restaurant_rlutter_ui/src/pages/languages.dart';
import 'package:restaurant_rlutter_ui/src/pages/login.dart';
import 'package:restaurant_rlutter_ui/src/pages/map.dart';
import 'package:restaurant_rlutter_ui/src/pages/menu_list.dart';
import 'package:restaurant_rlutter_ui/src/pages/messages.dart';
import 'package:restaurant_rlutter_ui/src/pages/mobile_verification.dart';
import 'package:restaurant_rlutter_ui/src/pages/mobile_verification_2.dart';
import 'package:restaurant_rlutter_ui/src/pages/pages.dart';
import 'package:restaurant_rlutter_ui/src/pages/signup.dart';
import 'package:restaurant_rlutter_ui/src/pages/tracking.dart';
import 'package:restaurant_rlutter_ui/src/pages/walkthrough.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Walkthrough());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/MobileVerification':
        return MaterialPageRoute(builder: (_) => MobileVerification());
      case '/MobileVerification2':
        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Pages':
        return MaterialPageRoute(
            builder: (_) => PagesTestWidget(
                  currentTab: args,
                ));
//      case '/Home':
//        return MaterialPageRoute(builder: (_) => HomeWidget());
      case '/Details':
        return MaterialPageRoute(builder: (_) => DetailsWidget(id: args));
      case '/Map':
        return MaterialPageRoute(builder: (_) => MapWidget());
      case '/Menu':
        return MaterialPageRoute(builder: (_) => MenuWidget());
      case '/Food':
        return MaterialPageRoute(
            builder: (_) => FoodWidget(
                  routeArgument: args as RouteArgument,
                ));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Messages':
        return MaterialPageRoute(builder: (_) => MessagesWidget());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => AccountWidget());
      case '/Tracking':
        return MaterialPageRoute(builder: (_) => TrackingWidget());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}