// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) {
  return Announcement(
    json['title'] as String,
    json['body'] as String,
    DateTime.parse(json['posted_on'] as String),
    DateTime.parse(json['edited_on'] as String),
  );
}

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'posted_on': instance.postedOn.toIso8601String(),
      'edited_on': instance.editedOn.toIso8601String(),
    };
