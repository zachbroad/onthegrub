import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/registration/bloc/registration_cubit.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/cancel_button.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/next_page_button.dart';
import 'package:onthegrubv2/core/auth/registration/widgets/text_field_next_button.dart';
import 'package:onthegrubv2/modules/widgets/custom_form_field.dart';
import 'package:onthegrubv2/utils/mixins/validations_mixin.dart';
import 'package:flutter/material.dart';

class UserRegistrationUsername extends StatefulWidget {
  final Function nextPage;
  final Function previousPage;
  UserRegistrationUsername(this.nextPage, this.previousPage);

  @override
  _UserRegistrationUsernameState createState() => _UserRegistrationUsernameState();
}

class _UserRegistrationUsernameState extends State<UserRegistrationUsername> {
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegistrationCubit _registrationCubit;

  @override
  void initState() {
    super.initState();
    _registrationCubit = BlocProvider.of<RegistrationCubit>(context, listen: false);
    username.text = _registrationCubit.state.userRegistration.username;
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
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
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: Text('Enter your username', style: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Center(
                      child: Stack(
                        children: [
                          Center(
                            child: CustomFormField(
                                controller: username,
                                labelText: 'Username',
                                validator: (username) => Validate.name(username),
                                onFieldSubmitted: (username) {
                                  if (_formKey.currentState.validate()) {
                                    _registrationCubit.state.userRegistration.username = username;
                                    FocusScope.of(context).unfocus();
                                    widget.nextPage();
                                  }
                                }),
                          ),
                          TextFieldNextButton(
                            onPressed: _validateAndNextPage,
                          )
                        ],
                      ),
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
      _registrationCubit.state.userRegistration.username = username.text;
      FocusScope.of(context).unfocus();
      widget.nextPage();
    }
  }
}
