import 'package:http/http.dart' as http;
import 'package:onthegrubv2/constants/api_path.dart';

class AuthService {
  static Future<dynamic> resetPassword(email) async {
    try {
      final response = await http.post(Uri.parse('${ApiPath.BASE_URL}/rest-auth/password/reset/'),
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
}
