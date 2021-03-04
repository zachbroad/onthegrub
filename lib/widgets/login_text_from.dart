import 'package:flutter/material.dart';

class LoginTextForm extends StatefulWidget {
  @override
  _LoginTextFormState createState() => _LoginTextFormState();
}

class _LoginTextFormState extends State<LoginTextForm> {
  TextEditingController textfield;
  @override
  void initState() {
    super.initState();
    textfield = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textfield,
      decoration: InputDecoration(),
    );
  }
}
