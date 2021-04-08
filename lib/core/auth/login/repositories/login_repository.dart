// TODO: actual --> this is just a sample
import 'package:dio/dio.dart';
import 'package:onthegrubv2/constants/api_path.dart';
import 'package:onthegrubv2/core/auth/login/models/user.dart';

class LoginRepository {
  final Dio _dio;

  LoginRepository(this._dio);

  Future<User> fetchUser(String token) async {
    var response = await _dio.get("${ApiPath.BASE_URL}/api/profile/?format=json",
        options: Options(headers: {'Accept': 'application/json', "Authorization": "Token $token"}));

    User user = User.fromJson(response.data);

    return user;
  }
}
