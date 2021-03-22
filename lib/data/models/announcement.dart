import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  final String title;
  final String body;

  @JsonKey(name: "posted_on")
  final DateTime postedOn;

  @JsonKey(name: "edited_on")
  final DateTime editedOn;

  Announcement(
    this.title,
    this.body,
    this.postedOn,
    this.editedOn,
  );

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
