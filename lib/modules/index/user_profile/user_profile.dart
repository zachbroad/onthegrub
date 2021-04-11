import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/core/auth/screens/splash_screen.dart';
import 'package:onthegrubv2/util/authentication.dart';
import 'package:onthegrubv2/utils/services/secure_storage_service.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text("Username"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await BlocProvider.of<AuthCubit>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
