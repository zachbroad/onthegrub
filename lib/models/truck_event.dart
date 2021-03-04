import 'package:json_annotation/json_annotation.dart';

part 'truck_event.g.dart';

@JsonSerializable()
class TruckScheduleEvent {
  int pk;
  int truck;
  String title;
  String description;
  String address;
  String geolocation;

  @JsonKey(name: "start_time")
  DateTime startTime;

  @JsonKey(name: "end_time")
  DateTime endTime;

  TruckScheduleEvent({
    this.pk,
    this.truck,
    this.title,
    this.description,
    this.address,
    this.geolocation,
  });

  factory TruckScheduleEvent.fromJson(Map<String, dynamic> json) => _$TruckScheduleEventFromJson(json);

  Map<String, dynamic> toJson() => _$TruckScheduleEventToJson(this);
}
