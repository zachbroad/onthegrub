import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onthegrubv2/models/user.dart';
import 'package:onthegrubv2/models/user_registration.dart';
import 'package:onthegrubv2/services/api.dart';
import 'package:onthegrubv2/util/urls.dart';
import 'package:provider/provider.dart';

class AuthService {
  static Future<dynamic> resetPassword(email) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/rest-auth/password/reset/'),
          headers: {'Accept': 'application/json'}, body: {"email": "$email"});
      if (response.statusCode == 200) {
        return response;
      } else {
        print(response.statusCode);
        throw Exception('Failed to load post');
      }
    } catch (er) {
      print('Error: ' + er.toString());
    }
  }

  static Future<bool> login(String username, password, context) async {
    /// Takes a username & password combination and attempts to acquire a JWT
    /// If JWT is acquired, it is stored into shared preferences securely through FSS

    // TODO: This is awful
    String _token;
    bool ret = false;
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/login-token/'),
          headers: {'Accept': 'application/json'}, body: {"username": "$username", "password": "$password"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        _token = json.decode(response.body)['token'];
        ret = await verifyToken(_token);
        FlutterSecureStorage fss = FlutterSecureStorage();
        await fss.write(key: 'jwt', value: _token);
        await fss.write(key: 'last_logged_in', value: username);
        getUserProfile(_token, context);
      }
    } catch (er) {
      print(er);
    }
    return ret;
  }

  // TODO: Verify JWT; on successful verification, return user data

  static Future<User> getUserProfile(token, context) async {
    var profile;
    try {
      final response = await http.get(Uri.parse('${URLS.BASE_URL}/api/profile/?format=json'),
          headers: {'Accept': 'application/json', "Authorization": "Token $token"});
      print(response.statusCode);
      var decode = json.decode(response.body);
      profile = User.fromJson(decode[0]);
      User user = Provider.of<User>(context, listen: false);
      user.copy(profile);

      return user;
    } catch (er) {
      throw (er);
    }
  }

  // Validate JWT
  static Future<bool> verifyToken(String token) async {
    try {
      final response = await http
          .post(Uri.parse('${URLS.BASE_URL}/validate-token/'), headers: {'Accept': 'application/json'}, body: {"token": "$token"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (er) {
      if (er == SocketException) {
        return false;
      }
      print(er);
      return false;
    }
    return false;
  }

  static Future<dynamic> register(UserRegistration user) async {
    try {
      final response = await http.post(
        Uri.parse('${URLS.BASE_URL}/rest-auth/registration/'),
        headers: {'Accept': 'application/json'},
        body: {
          "username": user.username,
          "email": user.email,
          "password1": user.password1,
          "password2": user.password2,
          "first_name": user.firstName,
          "last_name": user.lastName,
          "phone": user.phone
        },
      );
      Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 201) {
        FlutterSecureStorage fss = FlutterSecureStorage();
        try {
          await fss.write(key: 'jwt', value: data['key']);
        } catch (e) {
          print('$e');
        }
        if (user.mailingList) {
          bool success = await APIService.signUpMailingList(user.email);
          if (!success) throw Exception('Mailing list sign up failed');
        }

        return response;
      } else if (response.statusCode == 400) {
        List<String> errors = [];
        // checks each validation error the backend throws
        var keys = data.keys;
        for (String key in keys) {
          if (data[key] != null) {
            if (!errors.contains(data[key][0])) errors.add(data[key][0]);
          }
        }
        print(response.body);
        return response;
      } else if (response.statusCode == 503) {
        return response;
      }
    } catch (er) {
      print('Error: ' + er.toString());
    }
  }
}
