import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/config/routes/router.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/core/auth/login/bloc/login_cubit.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode usernameFocus;
  FocusNode passwordFocus;

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    usernameFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    usernameFocus = FocusNode();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: _formKey,
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Username field
            SizedBox(
              height: 50,
              width: 300,
              child: TextFormField(
                focusNode: usernameFocus,
                style: TextStyle(color: Colors.black87),
                autofocus: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordFocus),
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 8.0),
            // Password field
            SizedBox(
              height: 50,
              width: 300,
              child: TextFormField(
                focusNode: passwordFocus,
                style: TextStyle(color: Colors.black87),
                obscureText: true,
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (_) async {
                  BlocProvider.of<LoginCubit>(context).update(_usernameController.text, _passwordController.text);
                  bool x = await BlocProvider.of<LoginCubit>(context).login();
                  if (x)
                    AppRouter.router.navigateTo(context, Routes.index);
                  else
                    AppRouter.router.navigateTo(context, Routes.login);
                },
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black87),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            // Login button
            // RememberMe(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: TextButton(
                        onPressed: () async {
                          AppRouter.router.navigateTo(context, Routes.registration);
                        },
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: TextButton(
                        onPressed: () async {
                          bool x = await BlocProvider.of<LoginCubit>(context).login();
                          if (x)
                            AppRouter.router.navigateTo(context, Routes.index);
                          else
                            AppRouter.router.navigateTo(context, Routes.login);
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
