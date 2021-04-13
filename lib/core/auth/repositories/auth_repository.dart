import 'dart:io';
import 'package:dio/dio.dart';
import 'package:onthegrubv2/constants/api_path.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';
import 'package:onthegrubv2/utils/services/secure_storage_service.dart';

class AuthRepository {
  Dio _dio;

  AuthRepository() {
    _dio = Dio();
  }

  Future<bool> validateToken() async {
    try {
      String _token = await SecureStorageService().readToken();
      if (_token != null) {
        final response = await _dio.post("${ApiPath.BASE_URL}/validate-token/",
            data: {"token": "$_token"},
            options: Options(
              headers: {
                'Accept': 'application/json',
              },
            ));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return true;
        }
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

  Future<User> retrieveUserProfile() async {
    String _token = await SecureStorageService().readToken();

    try {
      final response = await _dio.get('${ApiPath.BASE_URL}/api/profile/?format=json',
          options: Options(headers: {'Accept': 'application/json', "Authorization": "Token $_token"}));
      print(response.data);
      User _user = User.fromJson(response.data[0]);

      return _user;
    } catch (er) {
      throw (er);
    }
  }
}
