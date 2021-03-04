import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/widgets/cancel_button.dart';
import 'package:onthegrub/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrub/screens/widgets/custom_form_field.dart';
import 'package:onthegrub/util/validations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserRegistrationUsername extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  UserRegistrationUsername({this.nextPage, this.previousPage});

  @override
  _UserRegistrationUsernameState createState() =>
      _UserRegistrationUsernameState();
}

class _UserRegistrationUsernameState extends State<UserRegistrationUsername> {
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserRegistration user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
    username.text = user.username;
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    UserRegistration user = Provider.of<UserRegistration>(context);

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
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: Text(
                        'Choose your username',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Colors.black.withAlpha(200)),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Stack(
                      children: [
                        Center(
                          child: CustomFormField(
                              controller: username,
                              labelText: 'Username',
                              validator: (username) => Validate.name(username),
                              onFieldSubmitted: (username) {
                                if (_formKey.currentState.validate()) {
                                  user.username = username;
                                  FocusScope.of(context).unfocus();
                                  widget.nextPage();
                                }
                              }),
                        ),
                        Positioned(
                          right: 15,
                          top: 12,
                          child: Container(
                              alignment: Alignment.center,
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.lightBlue,
                              ),
                              child: IconButton(
                                  iconSize: 16,
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: _validateAndNextPage)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CancelButton(onPressed: () {
              Navigator.of(context).pop();
            }),
            NextPageButton(onPressed: _validateAndNextPage),
          ],
        ));
  }

  _validateAndNextPage() {
    if (_formKey.currentState.validate()) {
      user.username = username.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
