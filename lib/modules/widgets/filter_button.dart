import 'package:flutter/material.dart';
import 'filter_dialog.dart';

class FilterIconButton extends StatefulWidget {
  @override
  _FilterIconButtonState createState() => _FilterIconButtonState();
}

class _FilterIconButtonState extends State<FilterIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return FilterDialog();
          },
        );
      },
    );
  }
}
