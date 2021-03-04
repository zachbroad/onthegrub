// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
    pk: json['pk'] as int,
    type: json['type'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    price: (json['price'] as num)?.toDouble(),
    featured: json['featured'] as bool,
  );
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'pk': instance.pk,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'featured': instance.featured,
    };
