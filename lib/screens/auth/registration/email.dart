import 'package:onthegrubv2/data/models/user_registration.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/text_field_next_button.dart';
import 'package:onthegrubv2/screens/widgets/custom_form_field.dart';
import 'package:onthegrubv2/util/validations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserRegistrationEmail extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  UserRegistrationEmail({this.nextPage, this.previousPage});

  @override
  _UserRegistrationEmailState createState() => _UserRegistrationEmailState();
}

class _UserRegistrationEmailState extends State<UserRegistrationEmail> {
  TextEditingController email = TextEditingController();
  TextEditingController confirmEmail = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode emailConfirmFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  UserRegistration user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
    email.text = user.email;
    confirmEmail.text = user.confirmEmail;
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    confirmEmail.dispose();
    emailFocus.dispose();
    emailConfirmFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: Text(
                        'Enter your email',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email
                        Center(
                          child: CustomFormField(
                              focusNode: emailFocus,
                              controller: email,
                              labelText: 'Email',
                              validator: (text) => Validate.email(text),
                              onFieldSubmitted: (email) {
                                FocusScope.of(context).requestFocus(emailConfirmFocus);
                                Validate.email(email);
                              }),
                        ),
                        SizedBox(height: 10),
                        // Confirm email
                        Stack(children: [
                          Center(
                            child: CustomFormField(
                              focusNode: emailConfirmFocus,
                              controller: confirmEmail,
                              onFieldSubmitted: (email) {
                                _validateAndNextPage();
                              },
                              labelText: 'Confirm email',
                              validator: (text) => Validate.confirmEmail(email.text, text),
                            ),
                          ),
                          TextFieldNextButton(
                            onPressed: _validateAndNextPage,
                          ),
                        ]),
                        // TODO: Grab from old project
                        // MailingListCheckbox(value: user.mailingList, onChanged: _updateMailingList),
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

  _updateMailingList(bool val) {
    user.mailingList = val;
  }

  _validateAndNextPage() {
    if (_formKey.currentState.validate() && email.text == confirmEmail.text) {
      user.email = email.text;
      user.confirmEmail = confirmEmail.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
