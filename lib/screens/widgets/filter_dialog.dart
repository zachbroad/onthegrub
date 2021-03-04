import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _onlineMenu;
  @override
  void initState() {
    super.initState();
    _onlineMenu = false;
  }

  // TODO: Actual filtering
  // - should we query the backend with the filters or just filter the list
  //    that we recieve intially
  // TODO: Build DropDownMenus and their respective options
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'Filter Options',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Divider(
              indent: 1,
              endIndent: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Distance:',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Type of food:',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ratings:',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Only foodtrucks with online menus:',
                ),
                Checkbox(
                    value: _onlineMenu,
                    onChanged: (val) {
                      setState(() {
                        _onlineMenu = val;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
