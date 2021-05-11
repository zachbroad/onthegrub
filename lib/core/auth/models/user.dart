import 'package:flutter/widgets.dart';
import 'package:onthegrubv2/data/models/favorite.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';

class User extends ChangeNotifier {
  int pk;
  String _username;
  String _email;
  String _phone;
  String _firstName;
  String _lastName;
  String _biography;
  String _profilePicture;
  List<Favorite> _favorites;
  List<Truck> trucks;

  User();

  User.fromJson(Map<String, dynamic> json)
      : pk = json['pk'],
        _username = json['username'],
        _email = json['email'],
        _biography = json['biography'],
        _profilePicture = json['profile_picture'] as String,
        _phone = json['phone'] != null ? json['phone'] : 'No number available.',
        _firstName = json['first_name'],
        _lastName = json['last_name'],
        trucks = json['trucks'] != null ? (json['trucks'] as List).map((i) => Truck.fromJson(i)).toList() : null,
        _favorites = json['favorite_trucks'] != null ? (json['favorite_trucks'] as List).map((i) => Favorite.fromJson(i)).toList() : null;

  User.fromDb(Map<String, dynamic> json)
      : pk = json['id'],
        _username = json['username'],
        _email = json['email'],
        _biography = json['biography'],
        _profilePicture = json['profile_picture'],
        _phone = json['phone'] != null ? json['phone'] : 'No number available.',
        _firstName = json['first_name'],
        _lastName = json['last_name'];

  Map<String, dynamic> toJson() => {
        'pk': pk,
        'username': _username,
        'email': _email,
        'profile_picture': _profilePicture,
        'biography': _biography,
        'phone': _phone != null ? _phone : 'No number available.',
        'first_name': _firstName,
        'last_name': _lastName,
        'favorite_trucks': _favorites,
        'trucks': trucks,
      };

  // needed id for better queries and decided to create specific function for to map
  Map<String, dynamic> toDb() => {
        'id': pk,
        'username': _username,
        'email': _email,
        'profile_picture': _profilePicture,
        'biography': _biography,
        'phone': _phone != null ? _phone : 'No number available.',
        'first_name': _firstName,
        'last_name': _lastName,
      };

  get username => _username;

  set username(String username) {
    this._username = username;
    notifyListeners();
  }

  get email => _email;

  set email(String email) {
    this._email = email;
    notifyListeners();
  }

  get phone => _phone;

  set phone(String phone) {
    this._phone = phone;
    notifyListeners();
  }

  get firstName => _firstName;

  set firstName(String firstName) {
    this._firstName = firstName;
    notifyListeners();
  }

  get lastName => _lastName;

  set lastName(String lastName) {
    this._lastName = lastName;
    notifyListeners();
  }

  List<Favorite> get favorites => _favorites;

  set favorites(List favorites) {
    this._favorites = favorites;
    notifyListeners();
  }

  get profilePicture => _profilePicture;

  set profilePicture(String image) {
    this._profilePicture = image;
    notifyListeners();
  }

  get biography => _biography;

  set biography(String text) {
    this._biography = text;
    notifyListeners();
  }

  void copy(User user) {
    this.pk = user.pk;
    this._username = user.username;
    this._email = user.email;
    this._phone = user.phone;
    this._firstName = user._firstName;
    this._lastName = user._lastName;
    this._favorites = user._favorites;
    this._profilePicture = user._profilePicture;
    this._biography = user._biography;
    this.trucks = user.trucks;
  }

  bool owns(Truck truck) {
    bool ret = false;
    // ignore: unnecessary_statements
    pk == truck.owner ? ret = true : null;
    return ret;
  }

  bool hasFavorited(int truckId) {
    if (favorites == null) {
      return false;
    }

    if (favorites.length > 0) {
      for (Favorite favorite in favorites) {
        if (favorite.truck == truckId) {
          return true;
        }
      }
    }
    return false;
  }

  clearFields() {
    pk = null;
    username = null;
    email = null;
    phone = null;
    firstName = null;
    lastName = null;
    biography = null;
    profilePicture = null;
    favorites = null;
    trucks = null;
  }

/*  Future<void> visit(Truck truck) async {
    Response resp = await OnTheGrubAPIService;
    if (resp.statusCode != 201) {
      print("Visit failed");
    } else if (resp.statusCode == 201) {

    }
  }*/

}
