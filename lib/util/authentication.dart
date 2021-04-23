import 'package:flutter/material.dart';
import 'package:onthegrubv2/config/routes/router.dart' show AppRouter;
import 'package:onthegrubv2/config/routes/routes.dart';
import 'package:onthegrubv2/core/auth/login/screens/login.dart';
import 'package:onthegrubv2/services/auth.dart';

class Auth {
  static Future<bool> attemptLogin(
      {@required BuildContext context, @required String username, @required String password, bool formKeyValid = true}) async {
    final auth = SnackBar(
      content: Text('Attempting authentication...'),
    );
    final incorrect = SnackBar(
      backgroundColor: Colors.red,
      content: Text('Incorrect username or password.'),
    );
    if (formKeyValid) {
      if (await AuthService.login(username, password, context)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(incorrect);
        return false;
      }
    } else
      return false;
  }

  static resetPassword({@required BuildContext context, @required String email, bool formKeyValid = true}) async {
    if (formKeyValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attempting to send password reset email...'),
        ),
      );
    }
    // POST registration to API
    final response = await AuthService.resetPassword(
      email,
    );
    print(response.statusCode);

    // Check user creation
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      AppRouter.router.navigateTo(context, Routes.login);
    }
    // Handle errors from register POST body response
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Reset password failed.'),
        ),
      );
    }
  }
}
