import 'package:json_annotation/json_annotation.dart';

part 'review_truck.g.dart';

@JsonSerializable()
class ReviewTruck {
  int pk;
  String title;
  String image;

  ReviewTruck({
    this.pk,
    this.title,
    this.image,
  });

  factory ReviewTruck.fromJson(Map<String, dynamic> json) => _$ReviewTruckFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewTruckToJson(this);
}
