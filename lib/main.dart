import 'package:flutter/material.dart';
import 'package:onthegrubv2/routes.dart';
import 'package:onthegrubv2/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnTheGrub',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
    );
  }
}
