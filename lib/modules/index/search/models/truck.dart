import 'dart:convert';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/google_maps_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onthegrubv2/data/models/menu.dart';
import 'package:onthegrubv2/data/models/review.dart';
import 'package:onthegrubv2/data/models/tag.dart';
import 'package:onthegrubv2/data/models/truck_event.dart';
import 'dart:core';


part 'truck.g.dart';

LatLng from(dynamic json) {
  var j = json.toString().split(',');
  return LatLng.fromJson([double.parse(j[0]), double.parse(j[1])]);
}

@JsonSerializable()
class Truck extends ChangeNotifier {
  int pk;

  @JsonKey(fromJson: from, toJson: jsonEncode)
  LatLng geolocation;
  List<Tag> tags;
  List<Review> reviews;
  List<TruckScheduleEvent> schedule;
  Menu menu;
  String address;
  String description;
  String image;
  String phone;
  String title;
  String website;
  bool live;
  double distance;
  double rating;
  int favorites;
  int owner;
  int visits;
  @JsonKey(name: "available_for_catering")
  bool availableForCatering;

  Truck({
    this.pk,
    this.address,
    this.availableForCatering,
    this.description,
    this.distance,
    this.favorites,
    this.geolocation,
    this.image,
    this.live,
    this.menu,
    this.owner,
    this.phone,
    this.rating,
    this.reviews,
    this.schedule,
    this.tags,
    this.title,
    this.visits,
    this.website,
  });

  factory Truck.fromJson(Map<String, dynamic> json) => _$TruckFromJson(json);

  Map<String, dynamic> toJson() => _$TruckToJson(this);

  String get shortenedDescription {
    return this.description.substring(0, 50) + '...';
  }

  double get latitude {
    if (geolocation == null) {
      return null;
    }
    return geolocation.latitude;
  }

  String get prettyRating {
    if (this.rating != null) {
      return "${this.rating} / 5.0";
    }

    return "unrated";
  }

  double get longitude {
    if (geolocation == null) {
      return null;
    }
    return geolocation.longitude;
  }

  bool get hasLocation {
    return ((latitude != null) && (longitude != null)) || (geolocation != null);
  }

  double distanceAway(LatLng fromLocation) {
    if (fromLocation != null && (latitude != null && longitude != null)) {
      return SphericalUtils.computeDistanceBetween(Point(fromLocation.latitude, fromLocation.longitude), Point(latitude, longitude));
    } else {
      return null;
    }
  }
}
