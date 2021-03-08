import 'package:flutter/material.dart';
import 'package:onthegrubv2/models/user.dart';
import 'package:onthegrubv2/screens/index/account.dart';
import 'package:onthegrubv2/screens/index/events.dart';
import 'package:onthegrubv2/screens/index/home.dart';
import 'package:onthegrubv2/screens/index/map.dart';
import 'package:onthegrubv2/screens/trucks.dart';
import 'package:provider/provider.dart';

class IndexScreen extends StatefulWidget {
  static const routeName = '/';
  final int initialPage;

  const IndexScreen({this.initialPage});

  @override
  IndexScreenState createState() => IndexScreenState();
}

enum PageOptions {
  home,
  // Make sure these 2 are commented out and stay in the correct spot or the IDs will not match
  //  notifications,
  search,
  events,
  map,
}

class IndexScreenState extends State<IndexScreen> {
  int _selectedPage = 0;
  int initialPage;
  var _pageOptions = [
    HomeScreen(),
    TrucksList(),
    EventsScreen(),
    MapScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    if (widget.initialPage != null) {
      _selectedPage = widget.initialPage;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (context, user, child) {
      if (user == null) {
        return Container(width: 0, height: 0);
      }
      return Scaffold(
        body: IndexedStack(
          index: _selectedPage,
          children: _pageOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          unselectedIconTheme: Theme.of(context).iconTheme,
          selectedItemColor: Theme.of(context).toggleableActiveColor,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(
              () {
                _selectedPage = index;
              },
            ); //
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Trucks List"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: "Events List"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Account"),
          ],
        ),
      );
    });
  }
}
