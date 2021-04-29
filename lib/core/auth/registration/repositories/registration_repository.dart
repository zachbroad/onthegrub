import 'package:dio/dio.dart';
import 'package:onthegrubv2/constants/api_path.dart';
import 'package:onthegrubv2/core/auth/registration/models/user_registration.dart';

class RegistrationRepository {
  Dio _dio;

  RegistrationRepository() {
    _dio = Dio();
  }

  Future<dynamic> register(UserRegistration user) async {
    try {
      final response = await _dio.post(
        '${ApiPath.BASE_URL}/rest-auth/registration/',
        data: {
          "username": user.username,
          "email": user.email,
          "password1": user.password1,
          "password2": user.password2,
          "first_name": user.firstName,
          "last_name": user.lastName,
          "phone": user.phone
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      Map<String, dynamic> data = response.data;
      if (response.statusCode == 201) {
        if (user.mailingList) {
          bool success = await signUpMailingList(user.email);
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
        print(response.data);
        return response;
      } else if (response.statusCode == 503) {
        return response;
      }
    } catch (er) {
      print('Error: ' + er.toString());
    }
  }

  Future<bool> signUpMailingList(String email) async {
    FormData formData = FormData.fromMap({'email': email});
    var response = await _dio.post(
      '${ApiPath.MAILING_LIST_URL}',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    return response.data;
  }
}
