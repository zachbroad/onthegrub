import 'package:json_annotation/json_annotation.dart';

part 'user_registration.g.dart';

@JsonSerializable()
class UserRegistration {
  String username;
  String email;
  String confirmEmail;
  String password1;
  String password2;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String phone;
  bool mailingList = false;
  UserRegistration();
}
