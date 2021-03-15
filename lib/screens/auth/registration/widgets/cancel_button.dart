import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final Function onPressed;
  CancelButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 10,
        top: 30,
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: onPressed,
          color: Colors.black.withOpacity(.7),
        ));
  }
}
