// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
    pk: json['pk'] as int,
    user: json['user'] as int,
    truck: json['truck'] as int,
  );
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'truck': instance.truck,
    };
