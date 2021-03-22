import 'package:onthegrubv2/data/models/menu_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  @JsonKey(name: "menu")
  List<MenuItem> items;

  Menu({this.items}) {
    items = <MenuItem>[];
  }

  List<MenuItem> get entres => items.where((e) => e.type == 1).toList();

  List<MenuItem> get sides => items.where((e) => e.type == 2).toList();

  List<MenuItem> get drinks => items.where((e) => e.type == 3).toList();

  List<MenuItem> get deserts => items.where((e) => e.type == 4).toList();

  List<MenuItem> get combos => items.where((e) => e.type == 5).toList();

  List<MenuItem> get featured => items.where((e) => e.featured == true).toList();

  Map<String, List<MenuItem>> get categories => {
        "Entrees": entres,
        "Sides": sides,
        "Drinks": drinks,
        "Desserts": deserts,
        "Combos": combos,
      };

  Menu.fromJson(List<dynamic> json) : items = buildMenu(json);

  static List<MenuItem> buildMenu(List<dynamic> json) {
    List<MenuItem> menu = [];
    for (dynamic item in json) {
      menu.add(MenuItem.fromJson(item));
    }
//    final menu = json.toList().map((dynamic item) => MenuItem.fromJson(item as Map<String, dynamic>));
    return menu;
  }

  static List<MenuItem> fieldFromJson(Map<String, dynamic> json, String field) {
    List<MenuItem> ret = [];
    try {
      var resp = (json[field] as List).map((i) => MenuItem.fromJson(i)).toList();
      ret = resp != null ? resp : ret;
    } catch (e) {}
    return ret;
  }

  Map<String, dynamic> toJson() => {
        'menu_items': items,
      };

  bool hasEntres() {
    return entres.isNotEmpty;
  }

  bool hasSides() {
    return sides.isNotEmpty;
  }

  bool hasDrinks() {
    return drinks.isNotEmpty;
  }

  bool hasDeserts() {
    return deserts.isNotEmpty;
  }

  bool hasCombos() {
    return combos.isNotEmpty;
  }
}
