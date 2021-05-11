import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';
import 'package:onthegrubv2/modules/index/widgets/user_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User _user;
  @override
  Widget build(BuildContext context) {
    _user = BlocProvider.of<AuthCubit>(context).state.user;
    return Center(
      child: _user.pk != null ? UserCard(_user) : Container(),
    );
  }
}
