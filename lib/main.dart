import 'package:flutter/material.dart';
import 'package:onthegrubv2/routes.dart';
import 'package:onthegrubv2/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: Routes.all(),
      title: 'OnTheGrub',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}
