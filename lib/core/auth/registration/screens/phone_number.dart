import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onthegrubv2/core/auth/registration/models/user_registration.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrubv2/services/auth.dart';
import 'package:onthegrubv2/utils/mixins/validations_mixin.dart';
import 'package:provider/provider.dart';

// TODO: 2-factor verification

class UserRegistrationPhoneNumber extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  const UserRegistrationPhoneNumber(this.nextPage, this.previousPage);
  @override
  _UserRegistrationPhoneNumberState createState() => _UserRegistrationPhoneNumberState();
}

class _UserRegistrationPhoneNumberState extends State<UserRegistrationPhoneNumber> {
  TextEditingController phone = TextEditingController();

  MaskTextInputFormatter maskFormatter = new MaskTextInputFormatter(mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});
  final _formKey = GlobalKey<FormState>();
  UserRegistration user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserRegistration>(context, listen: false);
    phone.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
                  child: Center(
                    child: Text(
                      'Enter your phone number',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: size.height * .1,
                          width: size.width * .95,
                          child: TextFormField(
                            style: TextStyle(color: Colors.black87),
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (phone) {
                              _validateAndNextPage();
                            },
                            controller: phone,
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [maskFormatter],
                            smartDashesType: SmartDashesType.enabled,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              // PADDING room for button layed over with stack
                              contentPadding: EdgeInsets.symmetric(horizontal: 64),
                              labelText: 'Phone Number',
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
                            validator: (phone) => Validate.phone(phone),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          LastPageButton(onPressed: widget.previousPage),
          // PLACEHOLDER LAST PAGE BUTTON
          Positioned(
            top: 30,
            right: 0,
            child: Container(
              child: TextButton(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () async {
                  var response = await AuthService.register(user);
                  print(response.statusCode);
                  if (response.statusCode == 201 || response.statusCode == 200) {
                    // If the user signed up for the mailing list and their email is valid
                    // TODO: mailing list
                    // user.mailingList ?? await APIService.signUpMailingList(user.email);
                    Navigator.pop(context, true);
                  } else if (response.statusCode == 400) {
                    // Check for errors thrown by db
                    Map<String, dynamic> data = json.decode(response.body);
                    data.forEach((key, value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$key: ${value[0]}'),
                      ));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(response.statusCode.toString()),
                    ));
                  }
                },
              ),
            ),
          ),
          // NextPageButton(onPressed: _validateAndNextPage),
        ]));
  }

  _validateAndNextPage() {
    if (_formKey.currentState.validate()) {
      user.phone = phone.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
