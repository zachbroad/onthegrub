import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  final Function onPressed;
  NextPageButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 10,
        top: 30,
        child: Material(
            color: Colors.transparent,
            child: IconButton(icon: Icon(Icons.arrow_forward), onPressed: onPressed, color: Colors.black.withOpacity(.7))));
  }
}
