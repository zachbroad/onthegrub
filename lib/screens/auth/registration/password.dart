import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrub/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrub/screens/widgets/custom_form_field.dart';
import 'package:onthegrub/util/validations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserRegistrationPassword extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  UserRegistrationPassword({this.nextPage, this.previousPage});

  @override
  _UserRegistrationPasswordState createState() => _UserRegistrationPasswordState();
}

class _UserRegistrationPasswordState extends State<UserRegistrationPassword> {
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserRegistration user;
  FocusNode password1Focus;
  FocusNode password2Focus;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
    password1.text = user.password1;
    password2.text = user.password2;
    password1Focus = FocusNode();
    password2Focus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    password1.dispose();
    password2.dispose();
    password1Focus.dispose();
    password2Focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primaryVariant, colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Enter your password',
                        style: Theme.of(context).textTheme.headline4.apply(color: Colors.black87),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: CustomFormField(
                            obscureText: true,
                            focusNode: password1Focus,
                            controller: password1,
                            labelText: 'Password',
                            validator: (password1) => Validate.password(password1),
                            // Don't know why I can't go to next focus
                            onFieldSubmitted: (password1) => FocusScope.of(context).requestFocus(password2Focus),
                          ),
                        ),
                        SizedBox(height: 16),
                        Stack(
                          children: [
                            Center(
                              child: CustomFormField(
                                  obscureText: true,
                                  focusNode: password2Focus,
                                  controller: password2,
                                  labelText: 'Confirm password',
                                  validator: (password2) => Validate.confirmPassword(password1.text, password2),
                                  onFieldSubmitted: (password2) {
                                    _validateAndNextPage();
                                  }),
                            ),
                            Positioned(
                              right: 15,
                              top: 12,
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.lightBlue),
                                  child: IconButton(iconSize: 16, icon: Icon(Icons.arrow_forward), onPressed: _validateAndNextPage)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            LastPageButton(onPressed: widget.previousPage),
            NextPageButton(onPressed: _validateAndNextPage),
          ],
        ));
  }

  _validateAndNextPage() {
    if (_formKey.currentState.validate()) {
      user.password1 = password1.text;
      user.password2 = password2.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
