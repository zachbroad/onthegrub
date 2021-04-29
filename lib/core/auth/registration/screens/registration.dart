import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/core/auth/registration/bloc/registration_cubit.dart';
import 'package:onthegrubv2/core/auth/registration/screens/location.dart';
import 'package:onthegrubv2/core/auth/registration/screens/password.dart';
import 'package:onthegrubv2/core/auth/registration/screens/phone_number.dart';
import 'package:onthegrubv2/core/auth/registration/screens/username.dart';

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

  int currentPage;
  PageController pageController;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    pageController = _pageController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationCubit(),
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