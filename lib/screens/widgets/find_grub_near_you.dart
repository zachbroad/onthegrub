import 'package:flutter/material.dart';
import 'package:onthegrub/screens/index/index.dart';

class FindGrubNearYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ElevatedButton(
          child: Text("FIND GRUB"),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IndexScreen(initialPage: PageOptions.search.index),
              ),
            );
          },
        ),
      ),
    );
  }
}
