import 'package:json_annotation/json_annotation.dart';
import 'package:onthegrubv2/data/models/review_truck.dart';
import 'package:onthegrubv2/core/auth/models/user.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  int id;
  String description;
  int rating;
  User reviewer;
  @JsonKey(name: "total_likes")
  int totalLikes;
  ReviewTruck truck;

  Review({
    this.id,
    this.description,
    this.rating,
    this.reviewer,
    this.totalLikes,
    this.truck,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

class ReviewResponse {
  final List<Review> reviews;

  const ReviewResponse({this.reviews});

  static ReviewResponse fromJson(Map<String, dynamic> json) {
    final items = (json['results'] as List<Review>).map((dynamic item) => Review.fromJson(item as Map<String, dynamic>)).toList();
    return ReviewResponse(reviews: items);
  }
}

class ReviewResultError {
  final String message;

  const ReviewResultError({this.message});

  static ReviewResultError fromJson(dynamic json) {
    return ReviewResultError(message: json['error'] as String);
  }
}
