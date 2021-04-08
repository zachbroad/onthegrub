import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onthegrubv2/modules/index/search/models/truck.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  int id;
  String title;
  String description;

  @JsonKey(name: "address", required: false)
  String address;

  @JsonKey(name: "geolocation", required: false)
  String location;

  @JsonKey(name: "start_time", required: true)
  DateTime startTime;

  @JsonKey(name: "end_time", required: true)
  DateTime endTime;

  @JsonKey(name: "cancelled_date", required: false)
  DateTime cancelledDate;

  @JsonKey(name: "trucks", required: false)
  List<Truck> trucks;

  Event({
    @required this.title,
    this.id,
    this.description,
    this.address,
    this.location,
    @required this.startTime,
    @required this.endTime,
    this.cancelledDate,
    this.trucks,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
