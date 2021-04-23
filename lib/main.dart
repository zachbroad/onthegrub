import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:onthegrubv2/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(App());
}
