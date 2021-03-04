// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistration _$UserRegistrationFromJson(Map<String, dynamic> json) {
  return UserRegistration()
    ..username = json['username'] as String
    ..email = json['email'] as String
    ..password1 = json['password1'] as String
    ..password2 = json['password2'] as String
    ..firstName = json['first_name'] as String
    ..lastName = json['last_name'] as String
    ..phone = json['phone'] as String
    ..mailingList = json['mailingList'] as bool;
}

Map<String, dynamic> _$UserRegistrationToJson(UserRegistration instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password1': instance.password1,
      'password2': instance.password2,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'mailingList': instance.mailingList,
    };
