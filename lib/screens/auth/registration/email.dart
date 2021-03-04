import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrub/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrub/screens/widgets/custom_form_field.dart';
import 'package:onthegrub/screens/widgets/mailing_list.dart';
import 'package:onthegrub/util/validations.dart';
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
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: Text(
                        'Now enter your email',
                        style: Theme.of(context).textTheme.headline4.apply(color: Colors.black87),
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
                            onFieldSubmitted: (firstName) => FocusScope.of(context).requestFocus(emailConfirmFocus),
                          ),
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
                        ]),
                        MailingListCheckbox(value: user.mailingList, onChanged: _updateMailingList),
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
