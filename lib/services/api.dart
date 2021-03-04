import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as fss;
import 'package:http/http.dart' as http;
import 'package:onthegrubv2/models/menu_item.dart';
import 'package:onthegrubv2/models/tag.dart';
import 'package:onthegrubv2/models/truck.dart';
import 'package:onthegrubv2/util/file.dart';
import 'package:onthegrubv2/util/urls.dart';
import 'package:dio/dio.dart';

class APIService {
  /* HELPER START */

  static Future<dynamic> _get(String url) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw SocketException("Network error");
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> _delete(String url) async {
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }

  /* HELPER END */

  /* ANNOUNCEMENTS START */

  static Future<Map<String, dynamic>> fetchAnnouncements() async {
    return await _get('${URLS.BASE_API_URL}/announcements/');
  }

//  static Future<String> fetchAnnouncementPage() {}

  /* ANNOUNCEMENTS END */

  /* NOTIFICATIONS START */

  static Future<Map<String, dynamic>> fetchNotifications() async {
    return await _get('${URLS.BASE_API_URL}/notifications/');
  }

  /* NOTIFICATIONS END */

  /* EVENTS START */

  static Future<Map<String, dynamic>> fetchEvents() async {
    return await _get('${URLS.BASE_API_URL}/events/');
  }

  /* EVENTS END */

  /* CATER START */

  static Future<Map<String, dynamic>> fetchCaters() async {
    return await _get('${URLS.BASE_API_URL}/caters/');
  }

  static Future<Map<String, dynamic>> fetchCaterRequestsByTruckID(int truckID) async {
    return await _get('${URLS.BASE_API_URL}/caters?search=$truckID');
  }

  /* CATER END */

  /* TRUCK DASHBOARD START */

  static Future<Map<String, dynamic>> fetchDashboard() async {
    return await _get('${URLS.BASE_API_URL}/dashboard/');
  }

  static Future<Map<String, dynamic>> fetchDashboardDetail(int truckID) async {
    return await _get('${URLS.BASE_API_URL}/dashboard/$truckID/');
  }

  /* TRUCK DASHBOARD END */

  /* TRUCKS START */

  static Future<Map<String, dynamic>> fetchTrucksList() async {
    return await _get('${URLS.BASE_API_URL}/trucks.json');
  }

  static Future<List<dynamic>> fetchTrendingTrucks() async {
    return await _get('${URLS.BASE_API_URL}/trucks/trending/');
  }

  static Future<List<dynamic>> fetchRecentTrucks() async {
    return await _get('${URLS.BASE_API_URL}/trucks/recent/');
  }

  static Future<List<dynamic>> fetchFavoriteTrucks() async {
    return await _get('${URLS.BASE_API_URL}/trucks/favorites/');
  }

  static Future<Map<String, dynamic>> fetchTrucksListByLocation(double lat, double lng) async {
    return await _get('${URLS.BASE_API_URL}/trucks/?geolocation=${lat.toString().trim()},${lng.toString().trim()}');
  }

  static Future<Map<String, dynamic>> fetchTrucksListByLocationAndDistance(double lat, double lng, double distance) async {
    return await _get('${URLS.BASE_API_URL}/trucks/?geolocation=${lat.toString().trim()},${lng.toString().trim()}&distance=$distance');
  }

  static Future<Map<String, dynamic>> fetchTruckDetail(pk) async {
    return await _get('${URLS.BASE_API_URL}/trucks/$pk');
  }

  static Future<Map<String, dynamic>> fetchTrucksByOwner(int pk) async {
    return await _get('${URLS.BASE_API_URL}/trucks/?owner=$pk');
  }

  static Future<Map<String, dynamic>> queryTrucksByTitleTagsStartsWith(String query) async {
    return await _get('${URLS.BASE_API_URL}/trucks/?title__startswith=$query&tags__title__startswith=$query');
  }

  static Future<Map<String, dynamic>> queryTrucksByTitleStartsWith(String query) async {
    return await _get('${URLS.BASE_API_URL}/trucks/?title__startwith=$query');
  }

  static Future<dynamic> patchLive(Truck truck, {String endTime}) async {
    Dio dio = Dio();
    Map<String, dynamic> e = {'truck': truck.pk};
    e.putIfAbsent('end_time', () => endTime);
    FormData formData = FormData.fromMap(e);

    var response = await dio.patch(
      '${URLS.BASE_API_URL}/trucks/${truck.pk}/live',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    return response.data;
  }

  static Future<dynamic> postLive(Truck truck, {String endTime}) async {
    Dio dio = Dio();

    Map<String, dynamic> e = {'truck': truck.pk};
    e.putIfAbsent('end_time', () => endTime);
    FormData formData = FormData.fromMap(e);
    var resp = await dio.post('${URLS.BASE_API_URL}/lives/',
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 401;
            }));
    return resp.data;
  }

  static Future<dynamic> postTruck(Truck truck) async {
    assert(truck.geolocation != null);
    var dio = new Dio();
    FormData formData = FormData.fromMap({
      'title': truck.title,
      'phone': truck.phone,
      'geolocation': '${truck.geolocation.latitude},${truck.geolocation.longitude}',
      'owner': truck.owner
    });
    var response = await dio.post(
      '${URLS.BASE_API_URL}/trucks/',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    return response;
  }

  static Future<Response> patchTruck(int pk,
      {String title,
      String image,
      String description,
      String address,
      String geolocation,
      String phone,
      String website,
      bool availableForCatering,
      List<Tag> tags,
      bool live}) async {
    Map<String, dynamic> body = {};
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    RegExp regExp = new RegExp(
      r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$",
      caseSensitive: false,
      multiLine: false,
    );
    if (title != null) {
      body.putIfAbsent("title", () => body['title'] = title);
    }
    if (image != null && regExp.hasMatch(image)) {
      body.putIfAbsent("image", () => body['image'] = image);
    }
    if (description != null) {
      body.putIfAbsent("description", () => body['description'] = description);
    }
    if (address != null) {
      body.putIfAbsent("address", () => body['address'] = address);
    }
    if (geolocation != null) {
      body.putIfAbsent("geolocation", () => body['geolocation'] = geolocation);
    }
    if (phone != null) {
      body.putIfAbsent("phone", () => body['phone'] = phone);
    }
    if (availableForCatering != null) {
      body.putIfAbsent("available_for_catering", () => body['available_for_catering'] = availableForCatering);
    }
    if (website != null) {
      body.putIfAbsent("website", () => body['website'] = website);
    }
    if (tags != null) {
      List<int> _tags = [];
      for (Tag tag in tags) {
        _tags.add(tag.pk);
      }

//      body.putIfAbsent("tags", () => body['tags'] = _tags);
      body['tags'] = _tags;
    }
    if (live != null) {
      body.putIfAbsent("live", () => body['live'] = live);
    }
    Dio dio = new Dio();

//    FormData formData = FormData.fromMap(body);

    Response response = await dio.patch(
      '${URLS.BASE_API_URL}/trucks/$pk/',
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
      data: body,
    );
    return response;
  }

  static Future postVisit(int userId, int truckId) async {
    var dio = new Dio();

    FormData favorite = FormData.fromMap(
      {"visitor": userId, "truck": truckId},
    );
    var response = await dio.post(
      '${URLS.BASE_API_URL}/visits/',
      data: favorite,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
    return response;
  }

  /* TRUCKS END */

  /* TRUCK SCHEDULE START */

  static Future<Response> deleteTruckEvent(int eventID) async {
    return await _delete('${URLS.BASE_API_URL}/schedules/$eventID/');
  }

  /* TRUCK SCHEDULE END */

  /* TAGS START */

  static Future<Map<String, dynamic>> fetchTag(String tag) async {
    return await _get('${URLS.BASE_API_URL}/tags/?title=$tag');
  }

  static Future<Map<String, dynamic>> fetchTags() async {
    return await _get('${URLS.BASE_API_URL}/tags/');
  }

  static Future<Map<String, dynamic>> fetchFeaturedTags() async {
    return await _get('${URLS.BASE_API_URL}/tags/?featured=True');
  }

  static Future<Map<String, dynamic>> queryTags(String tag) async {
    return await _get('${URLS.BASE_API_URL}/tags/?title=$tag');
  }

  /* TAGS END */

  /* REVIEWS START */

  static Future<Map<String, dynamic>> fetchReviews() async {
    return await _get('${URLS.BASE_API_URL}/reviews/');
  }

  static Future<Map<String, dynamic>> fetchReviewsByReviewId(int pk) async {
    return await _get('${URLS.BASE_API_URL}/reviews/$pk/');
  }

  static Future<Map<String, dynamic>> fetchReviewsByUserId(int id) async {
    return await _get('${URLS.BASE_API_URL}/reviews/?user=$id');
  }

  static Future<Map<String, dynamic>> fetchReviewsByTruckId(int id) async {
    return await _get('${URLS.BASE_API_URL}/reviews/?truck=$id');
  }

  static Future<void> postReview(int truckID, int rating, String description, int reviewer) async {
    var dio = new Dio();

    FormData reviewData =
        FormData.fromMap({"truck": truckID, "rating": rating, "description": description, "reviewer": reviewer.toString()});

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    await dio.post(
      '${URLS.BASE_API_URL}/reviews/',
      data: reviewData,
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
  }

  static Future<void> deleteReview(int reviewID) async {
    var dio = new Dio();

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    await dio.delete(
      '${URLS.BASE_API_URL}/reviews/$reviewID/',
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
  }

  /* REVIEWS END */

  /* USER START */

  static Future<Map<String, dynamic>> fetchFavoritesByUserId(int id) async {
    return await _get('${URLS.BASE_API_URL}/favorites/?user=$id');
  }

  static Future<Map<String, dynamic>> deleteFavoriteById(int id) async {
    return await _delete('${URLS.BASE_API_URL}/favorites/$id/');
  }

  static Future deleteFavoriteByLookup(int userId, int truckId) async {
    return await _delete('${URLS.BASE_API_URL}/favorites/?user=$userId&truck=$truckId');
  }

  static Future postFavorite(int userId, int truckId) async {
    var dio = new Dio();

    FormData favorite = FormData.fromMap(
      {"user": userId, "truck": truckId},
    );
    var response = await dio.post(
      '${URLS.BASE_API_URL}/favorites/',
      data: favorite,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
    return response;
  }

  static Future postFeedback(int user, String description, File image) async {
    String imageName;

    try {
      imageName = image.path.split('/').last;
    } catch (e) {
      print(e);
      image = await getFileFromAssets('truck_logo_placeholder.png');
      imageName = image.path.split('/').last;
    }
    var dio = new Dio();

    FormData formData = FormData.fromMap({
      "user": user,
      "description": description,
      "image": await MultipartFile.fromFile(image.path, filename: imageName),
    });
    var response = await dio.post(
      '${URLS.BASE_API_URL}/feedback/',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
    return response.statusCode;
  }

  static Future<Response> patchUser(int pk, {String username, String email, String phone, String firstName, String lastName}) async {
    Map<String, dynamic> body = {};
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }

    if (username != null) {
      body.putIfAbsent("username", () => body['username'] = username);
    }
    if (email != null) {
      body.putIfAbsent("email", () => body['email'] = email);
    }
    if (phone != null) {
      body.putIfAbsent("phone", () => body['phone'] = phone);
    }
    if (firstName != null) {
      body.putIfAbsent("first_name", () => body['first_name'] = firstName);
    }
    if (lastName != null) {
      body.putIfAbsent("last_name", () => body['last_name'] = lastName);
    }

    var dio = new Dio();
    FormData formData = FormData.fromMap(body);
    var response = await dio.patch(
      '${URLS.BASE_API_URL}/users/$pk/',
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
      data: formData,
    );
    return response;
  }

  static Future<Map<String, dynamic>> fetchUsersList() async {
    return await _get('${URLS.BASE_API_URL}/users.json');
  }

  static Future<Map<String, dynamic>> fetchUsersByName(username) async {
    return await _get('${URLS.BASE_API_URL}/users.json/?search=$username');
  }

  static Future<Map<String, dynamic>> fetchUsersByEmail(email) async {
    return await _get('${URLS.BASE_API_URL}/users.json/?search=$email');
  }

  static Future<Map<String, dynamic>> fetchHomepage() async {
    return await _get('${URLS.BASE_API_URL}/home/');
  }

  /* USER END */

  /* DEVICE START */

  static Future<Map<String, dynamic>> getDevice() async {
    Map<String, dynamic> headers = {};
    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }
    var dio = new Dio();

    var resp = await dio.get(
      '${URLS.BASE_API_URL}/devices/',
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 300;
        },
      ),
    );
    return resp.data;
  }

  static Future<Map<String, dynamic>> postDevice(String fcmToken, int userPk) async {
    Map<String, dynamic> headers = {};
    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }
    Map<String, dynamic> body = {'registration_id': fcmToken, 'user': '$userPk', 'type': 'android'};

    var dio = new Dio();
    FormData formData = FormData.fromMap(body);
    var data = {};
    try {
      var resp = await dio.post(
        '${URLS.BASE_API_URL}/devices/',
        options: Options(
          headers: headers,
          followRedirects: false,
          validateStatus: (status) {
            return status < 300;
          },
        ),
        data: formData,
      );
      data = resp.data;
    } catch (e) {
      print(e);
    }

    return data;
  }

  /* DEVICE END */

  /* MENU START */

  static Future<List<dynamic>> fetchMenuByTruck(pk) async {
    var data;
    var response = await _get('${URLS.BASE_API_URL}/trucks/$pk/');

    if (response['menu'].length > 0) {
      data = response['menu'];
    }

    return data;
  }

  static Future<Map<String, dynamic>> patchMenuItem(MenuItem menuItem) async {
    RegExp regExp = new RegExp(
      r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$",
      caseSensitive: false,
      multiLine: false,
    );
    Dio dio = Dio();
    Map<String, dynamic> e = menuItem.toJson();
    if (!regExp.hasMatch(menuItem.image)) {
      e.remove('image');
    }
    FormData formData = FormData.fromMap(e);
    var response = await dio.patch(
      '${URLS.BASE_API_URL}/menu-items/${menuItem.pk}/',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    print(response.data);

    return response.data;
  }

  static Future<Map<String, dynamic>> postMenuItem(Truck truck, MenuItem menuItem) async {
    Dio dio = Dio();
    Map<String, dynamic> json = menuItem.toJson();
    json.putIfAbsent("truck", () => truck.pk);
    json.remove("pk");
    FormData formData = FormData.fromMap(json);
    var response = await dio.post(
      '${URLS.BASE_API_URL}/menu-items/?truck=${truck.pk}',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    print(response.data);

    return response.data;
  }

  static Future<bool> deleteMenuItem(int menuItemID) async {
    var resp = await _delete('${URLS.BASE_API_URL}/menu-items/$menuItemID/');
    return resp.statusCode == 204 ? true : false;
  }

/* MENU END */

/* MAILING LIST*/

  static Future<bool> signUpMailingList(String email) async {
    Dio dio = Dio();

    FormData formData = FormData.fromMap({'email': email});
    var response = await dio.post(
      '${URLS.MAILING_LIST_URL}',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> patchNotification(int id, {bool seen}) async {
    Dio dio = Dio();
    Map<String, dynamic> e = {'seen': seen.toString()};
    FormData formData = FormData.fromMap(e);

    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    final String token = await fss.FlutterSecureStorage().read(key: 'jwt');
    if (token != null) {
      headers["Authorization"] = "Token $token";
    }
    var response = await dio.patch(
      '${URLS.BASE_API_URL}/notifications/$id/',
      data: formData,
      options: Options(
        headers: headers,
        followRedirects: false,
        validateStatus: (status) {
          return status < 401;
        },
      ),
    );
    print(response.data);

    return response.data;
  }
}
