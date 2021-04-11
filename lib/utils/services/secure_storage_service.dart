import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  FlutterSecureStorage fss;

  SecureStorageService() {
    fss = FlutterSecureStorage();
  }

  // -- Read --

  Future<String> read(String key) async {
    return await fss.read(key: key);
  }

  Future<String> readToken() async {
    return await fss.read(key: 'jwt');
  }

  // -- Write --

  Future<void> storeToken(String token) async {
    return await fss.write(key: 'jwt', value: token);
  }

  Future<void> listenLocation(String isListening, String userLocation) async {
    await fss.write(key: 'userLocation', value: userLocation);
    await fss.write(key: 'isListening', value: isListening);
  }

  // -- Delete --

  Future<void> logoutCurrentUser() async {
    await fss.delete(key: 'userLocation');
    await fss.delete(key: 'lastKnownLocation');
    await fss.delete(key: 'jwt');
    await fss.delete(key: 'isLoggedIn');
  }
}
