import 'package:flutter/material.dart';

class MailingListCheckbox extends StatefulWidget {
  final Function onChanged;
  final bool value;
  MailingListCheckbox({this.value, this.onChanged});
  @override
  _MailingListState createState() => _MailingListState();
}

class _MailingListState extends State<MailingListCheckbox> {
  bool _value;
  @override
  void initState() {
    if (widget.value == null)
      _value = false;
    else
      _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Would you like to sign up for our mailing list?', style: TextStyle(color: Colors.black.withOpacity(.7))),
          Theme(
            data: ThemeData.light(),
            child: Checkbox(
              value: _value,
              onChanged: (val) {
                setState(() {
                  _value = val;
                });
                widget.onChanged(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
