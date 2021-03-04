import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrub/screens/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrub/util/validations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

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
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primaryVariant, colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                      'What is your phone number?',
                      style: Theme.of(context).textTheme.headline4.apply(color: Colors.black87),
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
                      Positioned(
                        right: 15,
                        top: 8,
                        child: Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.lightBlue),
                            child: IconButton(iconSize: 16, icon: Icon(Icons.arrow_forward), onPressed: _validateAndNextPage)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          LastPageButton(onPressed: widget.previousPage),
          NextPageButton(onPressed: _validateAndNextPage),
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
