import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
// appending Model to class name cuz conflicting class names with Flutter
class NotificationModel {
  final int pk;
  final String title;
  final String description;
  final String route;
  final bool seen;

  @JsonKey(name: "webview_route")
  final String webviewRoute;

  @JsonKey(name: "posted_on")
  final DateTime postedOn;

  get hasRoute {
    return (route != null);
  }

  NotificationModel(this.pk, this.title, this.description, this.postedOn, this.seen, {this.route, this.webviewRoute});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
