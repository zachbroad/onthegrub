import 'package:flutter/material.dart';
import 'package:onthegrub/screens/auth/registration/email.dart';
import 'package:onthegrub/screens/auth/registration/name.dart';
import 'package:onthegrub/screens/auth/registration/password.dart';
import 'package:onthegrub/screens/auth/registration/phone_number.dart';
import 'package:onthegrub/screens/auth/registration/username.dart';
import 'package:provider/provider.dart';
import 'package:onthegrub/models/user_registration.dart';
import 'package:onthegrub/screens/auth/registration/location.dart';

class Registration extends StatefulWidget {
  static const routeName = '/user_registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

PageController _pageController = PageController(initialPage: 0);

class _RegistrationState extends State<Registration> {
  List<Widget> pages = [
    UserRegistrationUsername(nextPage: nextPage, previousPage: previousPage),
    UserRegistrationEmail(nextPage: nextPage, previousPage: previousPage),
    UserRegistrationPassword(nextPage: nextPage, previousPage: previousPage),
    UserRegistrationName(nextPage: nextPage, previousPage: previousPage),
    UserRegistrationPhoneNumber(nextPage, previousPage),
    UserRegistrationLocation(nextPage, previousPage),
  ];

  PageController pageController;
  int currentPage;
  UserRegistration user;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    user != null ?? user.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    pageController = _pageController;
    user = UserRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserRegistration>(
      create: (_) => user,
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: pages,
        ),
      ),
    );
  }
}

// Function callbacks passed to the child widgets in order to manage the pages otherwise we need to use keys somehow
nextPage() {
  _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.ease);
}

previousPage() {
  _pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.ease);
}
