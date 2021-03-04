// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag()
    ..pk = json['pk'] as int
    ..title = json['title'] as String
    ..featured = json['featured'] as bool
    ..icon = json['icon'] as String;
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'featured': instance.featured,
      'icon': instance.icon,
    };
