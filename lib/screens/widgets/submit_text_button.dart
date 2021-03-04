import 'package:flutter/material.dart';

class SubmitTextButton extends StatefulWidget {
  final Function onPressed;
  SubmitTextButton({this.onPressed});
  @override
  _SubmitTextButtonState createState() => _SubmitTextButtonState();
}

class _SubmitTextButtonState extends State<SubmitTextButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15,
      top: 12,
      child: Container(
          alignment: Alignment.center,
          height: 32,
          width: 32,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.lightBlue),
          child: IconButton(
            iconSize: 16,
            icon: Icon(Icons.arrow_forward),
            onPressed: widget.onPressed,
          )),
    );
  }
}
