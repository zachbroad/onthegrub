import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable()
class MenuItem {
  int pk;
  int type;
  String name;
  String description;
  String image;
  double price;
  bool featured;

  MenuItem({
    this.pk,
    this.type,
    this.name,
    this.description,
    this.image,
    this.price,
    this.featured,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

  setType(int type) {
    if (type >= 1 && type <= 5) {
      type = type;
    } else {
      throw FormatException("Type must be between 1 and 5.");
    }
  }
}
