import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/registration/bloc/registration_cubit.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/last_page_button.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/text_field_next_button.dart';
import 'package:onthegrubv2/modules/widgets/custom_form_field.dart';
import 'package:onthegrubv2/utils/mixins/validations_mixin.dart';
import 'package:flutter/material.dart';

class UserRegistrationPassword extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  UserRegistrationPassword(this.nextPage, this.previousPage);

  @override
  _UserRegistrationPasswordState createState() => _UserRegistrationPasswordState();
}

class _UserRegistrationPasswordState extends State<UserRegistrationPassword> {
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegistrationCubit _registrationCubit;
  FocusNode password1Focus;
  FocusNode password2Focus;

  @override
  void initState() {
    super.initState();
    _registrationCubit = BlocProvider.of<RegistrationCubit>(context, listen: false);
    password1.text = _registrationCubit.state.userRegistration.password1;
    password2.text = _registrationCubit.state.userRegistration.password2;
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
    _registrationCubit = BlocProvider.of<RegistrationCubit>(context);
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
                        'Enter your password',
                        style: Theme.of(context).textTheme.headline5,
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
                            TextFieldNextButton(
                              onPressed: _validateAndNextPage,
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
      _registrationCubit.state.userRegistration.password1 = password1.text;
      _registrationCubit.state.userRegistration.password2 = password2.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
