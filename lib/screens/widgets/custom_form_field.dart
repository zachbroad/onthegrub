import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function onFieldSubmitted;
  final String labelText;
  final Function validator;
  final FocusNode focusNode;
  final bool obscureText;
  final bool phoneNumberField;
  final TextInputAction textInputAction;

  CustomFormField({
    @required this.controller,
    @required this.onFieldSubmitted(text),
    this.labelText,
    this.validator(text),
    this.focusNode,
    this.obscureText = false,
    this.phoneNumberField = false,
    this.textInputAction = TextInputAction.go,
  });

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  MaskTextInputFormatter maskFormatter;
  @override
  Widget build(BuildContext context) {
    if (widget.phoneNumberField) maskFormatter = MaskTextInputFormatter(mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});
    FocusNode focusNode = widget.focusNode;
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .1,
      width: size.width * .95,
      child: TextFormField(
        focusNode: focusNode,
        obscureText: widget.obscureText,
        style: TextStyle(color: Colors.black87),
        textInputAction: widget.textInputAction,
        autofocus: true,
        inputFormatters: maskFormatter != null ? [maskFormatter] : null,
        keyboardType: widget.phoneNumberField ? TextInputType.phone : null,
        smartDashesType: widget.phoneNumberField ? SmartDashesType.enabled : SmartDashesType.disabled,
        controller: widget.controller,
        maxLength: 120,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black87),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          counterStyle: TextStyle(color: Colors.black.withOpacity(.7)),
          filled: true,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}
