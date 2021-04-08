import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text("Username"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
//    onPressed: GoTo(SettingsScreen()),
          )
        ],
      ),
    );
  }
}
