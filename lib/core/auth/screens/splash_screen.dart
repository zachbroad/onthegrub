import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/constants/assets_path.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'dart:async';

import 'package:onthegrubv2/utils/services/rest_api_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            image: AssetImage(Assets.logo),
          ),
        ),
      ),
    );
  }

  startTimer() async {
    bool x = await BlocProvider.of<AuthCubit>(context).authenticate();
    if (x)
      AppRouter.router.navigateTo(context, Routes.index);
    else
      AppRouter.router.navigateTo(context, Routes.login);
  }

  // navigateUser() async {
  //   String token = await SecureStorageService().readToken();

  //   if (token == null)
  //     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  //   else {
  //     // check if JWT is valid
  //     bool authenticated = await AuthService.verifyToken(token);
  //     if (authenticated) {
  //       User user = await AuthService.getUserProfile(token, context);
  //       // TODO: device registration (needed for Firebase Notifications)
  //       // Verify if there is a duplciate device token
  //       //    if there is, ignore posting device
  //       // if (!await verifyDuplicateToken(_deviceToken)) {
  //       //   await APIService.postDevice(_deviceToken, user.pk);
  //       // }

  //       Navigator.pushNamed(context, IndexScreen.routeName);
  //     } else {
  //       await Auth.logout();
  //       Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  //     }
  //   }
  // }

  Future<bool> verifyDuplicateToken(currentId) async {
    Map<String, dynamic> notification = await APIService.getDevice();
    List<dynamic> devices = notification['results'];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]['registration_id'] == currentId) return true;
    }
    return false;
  }
}
