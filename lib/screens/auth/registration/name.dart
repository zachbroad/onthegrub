import 'package:onthegrubv2/models/user_registration.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrubv2/screens/auth/registration/widgets/text_field_next_button.dart';
import 'package:onthegrubv2/screens/widgets/custom_form_field.dart';
import 'package:onthegrubv2/util/validations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserRegistrationName extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;

  UserRegistrationName({this.nextPage, this.previousPage});

  @override
  _UserRegistrationNameState createState() => _UserRegistrationNameState();
}

class _UserRegistrationNameState extends State<UserRegistrationName> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserRegistration user;
  FocusNode firstNameFocus;
  FocusNode lastNameFocus;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
    firstName.text = user.firstName;
    lastName.text = user.lastName;
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    firstNameFocus.dispose();
    lastName.dispose();
    lastNameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Enter your name',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        CustomFormField(
                          focusNode: firstNameFocus,
                          controller: firstName,
                          labelText: 'First name',
                          validator: (firstName) => Validate.name(firstName),
                          onFieldSubmitted: (firstName) => FocusScope.of(context).requestFocus(lastNameFocus),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            // Stack wraps around the textfield in attempt to have a trailing button with material feel
                            Stack(
                              children: [
                                CustomFormField(
                                    focusNode: lastNameFocus,
                                    controller: lastName,
                                    labelText: 'Last name',
                                    validator: (lastName) => Validate.name(lastName),
                                    onFieldSubmitted: (lastName) {
                                      _validateAndNextPage();
                                    }),
                                // attempt at trailing button with material feel

                                TextFieldNextButton(
                                  onPressed: _validateAndNextPage,
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            LastPageButton(onPressed: widget.previousPage),
            NextPageButton(onPressed: _validateAndNextPage)
          ],
        ));
  }

  _validateAndNextPage() {
    if (_formKey.currentState.validate()) {
      user.firstName = firstName.text;
      user.lastName = lastName.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
