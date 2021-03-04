import 'package:flutter/material.dart';

class WhiteContainer extends StatelessWidget {
  final Widget child;

  WhiteContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.symmetric(
          vertical: BorderSide(
              color: Theme.of(context).dividerColor
          ),
        ),
//        border: Border.all(color: Colors.black),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(0.0), // Todo: implement this and remove the hardcoded ones in the views themselves
        child: this.child,
      ),
    );
  }
}
