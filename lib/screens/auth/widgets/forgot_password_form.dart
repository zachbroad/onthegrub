import 'package:flutter/material.dart';
import 'package:onthegrubv2/util/authentication.dart';
import 'package:onthegrubv2/util/validations.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  ForgotPasswordFormState createState() => ForgotPasswordFormState();
}

class ForgotPasswordFormState extends State<ForgotPasswordForm> {
  TextEditingController _emailController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email field
          TextFormField(
            style: Theme.of(context).textTheme.caption,
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email', labelStyle: Theme.of(context).textTheme.caption),
            validator: (value) => Validate.email(value),
          ),

          // Register button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 30,
              width: double.infinity,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    Auth.resetPassword(buildContext: context, email: _emailController.text, formKeyValid: _formKey.currentState.validate());
                  },
                  child: Text('Reset Password', style: TextStyle(color: Colors.white70)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
