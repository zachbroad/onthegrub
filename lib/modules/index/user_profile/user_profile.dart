import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(BlocProvider.of<AuthCubit>(context).state.user.username),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              bool boo = await BlocProvider.of<AuthCubit>(context).logout();
              if (boo) AppRouter.router.navigateTo(context, Routes.login, replace: true);
            },
          ),
        ],
      ),
    );
  }
}
