import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  @override
  _RememberMeState createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  // TODO: functionality
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(.7) : Colors.black.withOpacity(.7);
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Remember me', style: TextStyle(color: textColor)),
            Checkbox(
              value: false,
              onChanged: (val) {},
            ),
          ],
        ),
      ),
    );
  }
}
