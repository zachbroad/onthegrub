import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/constants/assets_path.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/utils/services/rest_api_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
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

  navigate() async {
    await BlocProvider.of<AuthCubit>(context).authenticate();
    AppRouter.router.navigateTo(context, Routes.index);
  }

  // Used for devices and notifications
  Future<bool> verifyDuplicateToken(currentId) async {
    Map<String, dynamic> notification = await APIService.getDevice();
    List<dynamic> devices = notification['results'];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]['registration_id'] == currentId) return true;
    }
    return false;
  }
}
