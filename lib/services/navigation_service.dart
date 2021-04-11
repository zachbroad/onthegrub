import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> goToReplacementNamed(String routeName) {
    return navigationKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> goTo(String routeName) {
    return navigationKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> goToRoute(MaterialPageRoute route) {
    return navigationKey.currentState.push(route);
  }

  pop() {
    return navigationKey.currentState.pop();
  }
}
