import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  final Function onPressed;
  DoneButton(this.onPressed);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('DONE'),
      onPressed: onPressed,
    );
  }
}
