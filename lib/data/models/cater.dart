import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cater.g.dart';

@JsonSerializable()
class Cater {
  int id;
  String name;
  String email;
  String phone;
  String details;
  int truck;
  DateTime when;

  @JsonKey(name: "requested_on")
  DateTime requestedOn;
  double duration;

  Cater({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.details,
    @required this.truck,
    @required this.when,
    @required this.requestedOn,
    @required this.duration,
  });

  factory Cater.fromJson(Map<String, dynamic> json) => _$CaterFromJson(json);

  Map<String, dynamic> toJson() => _$CaterToJson(this);
}
