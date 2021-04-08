import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Text("Events"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("Events", style: theme.textTheme.headline5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
