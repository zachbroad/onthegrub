import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  AppStateNotifier() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("dark_mode")) {
        if (prefs.getBool("dark_mode") == true) {
          updateTheme(true);
        } else {
          // need to check these elses seperately, cannot just update false at the end because it overrides the true in the line above
          updateTheme(false);
        }
      } else {
        updateTheme(false);
      }
    });
  }

  get isDarkMode => _isDarkMode;

  void updateTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('dark_mode', isDarkMode);
    });
    notifyListeners();
  }
}
