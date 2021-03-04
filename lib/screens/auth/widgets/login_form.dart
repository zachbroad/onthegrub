import 'package:flutter/material.dart';
import 'package:onthegrubv2/models/user.dart';
import 'package:onthegrubv2/screens/index/index_screen.dart';
import 'package:onthegrubv2/util/authentication.dart';
import 'package:provider/provider.dart';

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
    return Consumer<User>(
      builder: (context, user, child) {
        return Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Username field
                Container(
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
                Container(
                  child: TextFormField(
                    focusNode: passwordFocus,
                    style: TextStyle(color: Colors.black87),
                    obscureText: true,
                    textInputAction: TextInputAction.go,
                    onFieldSubmitted: (_) async {
                      login();
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
                          child: ElevatedButton(
                            onPressed: () async {
                              // Navigator.pushNamed(context, Registration.routeName);
                            },
                            child: Text('REGISTER'),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ElevatedButton(
                            onPressed: () async {
                              login();
                            },
                            child: Text('LOGIN'),
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
      },
    );
  }

  login() async {
    if (await Auth.attemptLogin(context: context, username: _usernameController.text, password: _passwordController.text))
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IndexScreen(),
        ),
      );
  }
}
