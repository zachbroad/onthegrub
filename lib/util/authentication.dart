import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onthegrubv2/screens/auth/login.dart';
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
      // ScaffoldMessenger.of(context).showSnackBar(auth);
      if (await AuthService.login(username, password, context)) {
        FlutterSecureStorage fss = FlutterSecureStorage();
        await fss.write(key: 'username', value: username);
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

  static Future<Null> logout() async {
    FlutterSecureStorage fss = FlutterSecureStorage();
    await fss.delete(key: 'userLocation');
    await fss.delete(key: 'lastKnownLocation');
    await fss.delete(key: 'jwt');
    await fss.delete(key: 'isLoggedIn');
    await fss.delete(key: 'username');
  }

  static resetPassword({@required BuildContext buildContext, @required String email, bool formKeyValid = true}) async {
    if (formKeyValid) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
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
      ScaffoldMessenger.of(buildContext).hideCurrentSnackBar();

      Navigator.pushNamed(buildContext, LoginScreen.routeName);
    }
    // Handle errors from register POST body response
    else {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Reset password failed.'),
        ),
      );
    }
  }
}
