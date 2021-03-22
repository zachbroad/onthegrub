// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TruckScheduleEvent _$TruckScheduleEventFromJson(Map<String, dynamic> json) {
  return TruckScheduleEvent(
    pk: json['pk'] as int,
    truck: json['truck'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    address: json['address'] as String,
    geolocation: json['geolocation'] as String,
  )
    ..startTime = json['start_time'] == null
        ? null
        : DateTime.parse(json['start_time'] as String)
    ..endTime = json['end_time'] == null
        ? null
        : DateTime.parse(json['end_time'] as String);
}

Map<String, dynamic> _$TruckScheduleEventToJson(TruckScheduleEvent instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'truck': instance.truck,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'geolocation': instance.geolocation,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
    };
