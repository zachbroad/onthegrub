// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['start_time', 'end_time']);
  return Event(
    title: json['title'] as String,
    id: json['id'] as int,
    description: json['description'] as String,
    address: json['address'] as String,
    location: json['geolocation'] as String,
    startTime: json['start_time'] == null
        ? null
        : DateTime.parse(json['start_time'] as String),
    endTime: json['end_time'] == null
        ? null
        : DateTime.parse(json['end_time'] as String),
    cancelledDate: json['cancelled_date'] == null
        ? null
        : DateTime.parse(json['cancelled_date'] as String),
    trucks: (json['trucks'] as List)
        ?.map(
            (e) => e == null ? null : Truck.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'geolocation': instance.location,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'cancelled_date': instance.cancelledDate?.toIso8601String(),
      'trucks': instance.trucks,
    };
