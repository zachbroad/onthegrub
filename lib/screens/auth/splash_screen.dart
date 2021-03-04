import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onthegrubv2/models/user.dart';
import 'dart:async';

import 'package:onthegrubv2/screens/auth/login.dart';
import 'package:onthegrubv2/services/api.dart';
import 'package:onthegrubv2/services/auth.dart';
import 'package:onthegrubv2/util/authentication.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _deviceToken;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
          ),
        ),
      ),
    );
  }

  startTimer() {
    Timer(Duration(seconds: 1), () {
      navigateUser();
    });
  }

  navigateUser() async {
    FlutterSecureStorage fss = FlutterSecureStorage();
    String token = await fss.read(key: 'jwt');

    if (token == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }

    if (token != null) {
      // check if JWT is valid
      bool authenticated = await AuthService.verifyToken(token);
      if (authenticated) {
        User user = await AuthService.getUserProfile(token, context);
        // Verify if there is a duplciate device token
        //    if there is, ignore posting device
        if (!await verifyDuplicateToken(_deviceToken)) {
          await APIService.postDevice(_deviceToken, user.pk);
        }

        // Navigator.pushNamed(context, IndexScreen.routeName);
      } else {
        await Auth.logout();
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  Future<bool> verifyDuplicateToken(currentId) async {
    Map<String, dynamic> notification = await APIService.getDevice();
    List<dynamic> devices = notification['results'];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]['registration_id'] == currentId) return true;
    }
    return false;
  }
}
