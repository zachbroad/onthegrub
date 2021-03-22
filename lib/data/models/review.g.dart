// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    id: json['id'] as int,
    description: json['description'] as String,
    rating: json['rating'] as int,
    reviewer: json['reviewer'] == null
        ? null
        : User.fromJson(json['reviewer'] as Map<String, dynamic>),
    totalLikes: json['total_likes'] as int,
    truck: json['truck'] == null
        ? null
        : ReviewTruck.fromJson(json['truck'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'rating': instance.rating,
      'reviewer': instance.reviewer,
      'total_likes': instance.totalLikes,
      'truck': instance.truck,
    };
