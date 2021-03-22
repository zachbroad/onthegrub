// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cater.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cater _$CaterFromJson(Map<String, dynamic> json) {
  return Cater(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    details: json['details'] as String,
    truck: json['truck'] as int,
    when: json['when'] == null ? null : DateTime.parse(json['when'] as String),
    requestedOn: json['requested_on'] == null
        ? null
        : DateTime.parse(json['requested_on'] as String),
    duration: (json['duration'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CaterToJson(Cater instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'details': instance.details,
      'truck': instance.truck,
      'when': instance.when?.toIso8601String(),
      'requested_on': instance.requestedOn?.toIso8601String(),
      'duration': instance.duration,
    };
