// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_truck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewTruck _$ReviewTruckFromJson(Map<String, dynamic> json) {
  return ReviewTruck(
    pk: json['pk'] as int,
    title: json['title'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ReviewTruckToJson(ReviewTruck instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'image': instance.image,
    };
