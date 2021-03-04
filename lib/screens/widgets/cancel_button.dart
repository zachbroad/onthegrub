import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'CANCEL',
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
