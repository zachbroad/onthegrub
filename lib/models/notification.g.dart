// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    json['pk'] as int,
    json['title'] as String,
    json['description'] as String,
    json['posted_on'] == null
        ? null
        : DateTime.parse(json['posted_on'] as String),
    json['seen'] as bool,
    route: json['route'] as String,
    webviewRoute: json['webview_route'] as String,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'route': instance.route,
      'seen': instance.seen,
      'webview_route': instance.webviewRoute,
      'posted_on': instance.postedOn?.toIso8601String(),
    };
