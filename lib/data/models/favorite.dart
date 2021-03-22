import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite {
  int pk;
  int user;
  int truck;

  Favorite({
    @required this.pk,
    @required this.user,
    @required this.truck,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
