import 'package:dio/dio.dart';
import 'package:onthegrubv2/constants/api_path.dart';
import 'package:onthegrubv2/utils/services/secure_storage_service.dart';

class LoginRepository {
  Dio _dio;

  LoginRepository() {
    _dio = Dio();
  }

  Future<bool> retrieveToken(String username, password) async {
    try {
      final response = await _dio.post('${ApiPath.BASE_URL}/login-token/',
          data: {"username": "$username", "password": "$password"}, options: Options(headers: {'Accept': 'application/json'}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        String _token = response.data['token'];
        await SecureStorageService().storeToken(_token);
        return true;
      }
      if (response.statusCode == 400) {
        return false;
      }
    } catch (er) {
      print(er);
    }
    return false;
  }
}
