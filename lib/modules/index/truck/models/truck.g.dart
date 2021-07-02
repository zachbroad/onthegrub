// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Truck _$TruckFromJson(Map<String, dynamic> json) {
  return Truck(
    pk: json['pk'] as int,
    address: json['address'] as String,
    availableForCatering: json['available_for_catering'] as bool,
    description: json['description'] as String,
    distance: (json['distance'] as num)?.toDouble(),
    favorites: json['favorites'] as int,
    geolocation: from(json['geolocation']),
    image: json['image'] as String,
    live: json['live'] as bool,
    menu: json['menu'] == null ? null : Menu.fromJson(json['menu'] as List),
    owner: json['owner'] as int,
    phone: json['phone'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    schedule: (json['schedule'] as List)?.map((e) => e == null ? null : TruckScheduleEvent.fromJson(e as Map<String, dynamic>))?.toList(),
    tags: (json['tags'] as List)?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))?.toList(),
    title: json['title'] as String,
    visits: json['visits'] as int,
    website: json['website'] as String,
  );
}

Map<String, dynamic> _$TruckToJson(Truck instance) => <String, dynamic>{
      'pk': instance.pk,
      'geolocation': jsonEncode(instance.geolocation),
      'tags': instance.tags,
      'schedule': instance.schedule,
      'menu': instance.menu,
      'address': instance.address,
      'description': instance.description,
      'image': instance.image,
      'phone': instance.phone,
      'title': instance.title,
      'website': instance.website,
      'live': instance.live,
      'distance': instance.distance,
      'rating': instance.rating,
      'favorites': instance.favorites,
      'owner': instance.owner,
      'visits': instance.visits,
      'available_for_catering': instance.availableForCatering,
    };
