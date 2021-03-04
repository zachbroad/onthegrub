import 'package:flutter/material.dart';

class LastPageButton extends StatelessWidget {
  final Function onPressed;
  LastPageButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 10,
        top: 30,
        child: Material(
            color: Colors.transparent,
            child: IconButton(icon: Icon(Icons.arrow_back), onPressed: onPressed, color: Colors.black.withOpacity(.7))));
  }
}
