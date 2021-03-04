import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:http/http.dart' as http;

class API {
  static Future<dynamic> _get(String url) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw SocketException("Network error");
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> _delete(String url) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }
}
