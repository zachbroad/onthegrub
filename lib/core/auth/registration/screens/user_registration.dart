import 'package:flutter/material.dart';
import 'package:onthegrubv2/core/auth/registration/models/user_registration.dart';
import 'package:onthegrubv2/core/auth/registration/screens/location.dart';
import 'package:onthegrubv2/core/auth/registration/screens/password.dart';
import 'package:onthegrubv2/core/auth/registration/screens/phone_number.dart';
import 'package:onthegrubv2/core/auth/registration/screens/username.dart';
import 'package:provider/provider.dart';

import 'email.dart';
import 'name.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

PageController _pageController = PageController(initialPage: 0);

class _RegistrationScreenState extends State<RegistrationScreen> {
  List<Widget> pages = [
    UserRegistrationUsername(nextPage, previousPage),
    UserRegistrationEmail(nextPage, previousPage),
    UserRegistrationPassword(nextPage, previousPage),
    UserRegistrationName(nextPage, previousPage),
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
