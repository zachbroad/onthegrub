import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/blocs/location_cubit.dart';
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/core/auth/bloc/auth_cubit.dart';
import 'package:onthegrubv2/modules/index/home/home.dart';
import 'package:onthegrubv2/modules/index/truck_search/screens/truck_list.dart';
import 'package:onthegrubv2/modules/index/user_profile/user_profile.dart';

class IndexScreen extends StatefulWidget {
  final int initialPage;

  const IndexScreen({this.initialPage});

  @override
  IndexScreenState createState() => IndexScreenState();
}

class IndexScreenState extends State<IndexScreen> {
  int _selectedPage = 0;
  int initialPage;
  var _pageOptions = [
    HomeScreen(),
    TruckSearchScreen(),
    UserProfileScreen(),
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
    if (BlocProvider.of<AuthCubit>(context).state.user.pk == null) {
      FluroRouter.appRouter.navigateTo(context, Routes.login);
    }
    BlocProvider.of<LocationCubit>(context).requestPermission();
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Trucks List"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
    );
  }
}
