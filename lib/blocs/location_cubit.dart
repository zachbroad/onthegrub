import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location location = Location();
  String _address;
  LatLng userLocation;
  LatLng lastKnownUserLocation;
  bool _isListening = false;
  FlutterSecureStorage fss;
  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;

  LocationData get locationData => _location;

  bool get isListening => _isListening;

  String get address => _address;

  LocationCubit() : super(LocationInitial()) {
    checkPermissions().then((e) {
      fss = FlutterSecureStorage();
      String fssUserLocation;
      // Check users last known location *If they have one*
      fss.read(key: 'lastKnownLocation').then((value) {
        if (value != null) {
          print('lastKnownLocation: $value');
          fssUserLocation = value;
          List locStringList = fssUserLocation.split(',');
          try {
            lastKnownUserLocation = LatLng(double.parse(locStringList[0]), double.parse(locStringList[1]));
          } catch (e) {
            throw FormatException('Tried to parse a double from location string');
          }
        }
      });
    });
  }

  checkPermissions() async {
    // TODO: redo permission logic, they changed the statuses
    location.hasPermission().then((isGranted) {
      if (isGranted == PermissionStatus.denied) {
        location.requestPermission().then((isGranted) {
          if (isGranted == PermissionStatus.denied) {
            // END OF ROAD
          } else if (isGranted == PermissionStatus.granted) {
            location.serviceEnabled().then((isGranted) {
              isGranted
                  ? listenLocation()
                  : location.requestService().then((isGranted) {
                      isGranted ?? listenLocation();
                    });
            });
          }
        });
      } else if (isGranted == PermissionStatus.granted) {
        location.serviceEnabled().then((isGranted) {
          isGranted
              ? listenLocation()
              : location.requestService().then((isGranted) {
                  isGranted ?? listenLocation();
                });
        });
      }
    });
  }

  listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((err) {
      // Handle location error
      _locationSubscription.cancel();
      _isListening = false;
      _address = null;
      throw Exception(err);
    }).listen((LocationData currentLocation) {
      // looks redundant, but when the stream is finished it sets both to null and doesnt save the last known location
      _location = currentLocation != null ? currentLocation : _location;

      if (currentLocation != null)
        userLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
      else
        userLocation = userLocation;
      _address = 'Using Current Location';
      _isListening = true;
      fss.write(key: 'userLocation', value: '${userLocation.latitude},${userLocation.longitude}');
      fss.write(key: 'isListening', value: _isListening.toString());
    });
  }

  stopListen({LatLng location, String add}) async {
    _locationSubscription.cancel().whenComplete(() => null);
    _isListening = false;
    _address = null;
    userLocation = null;
    if (add != null) _address = add;
    if (location != null) userLocation = location;
  }

  Future<void> requestPermission() async {
    try {
      emit(LocationPermissionLoading());
      final status = await location.requestPermission();
      emit(LocationPermission(status));
    } catch (e) {
      emit(LocationError(e.toString()));
      print(e.toString());
    }
  }

  Future<void> getLocation() async {
    try {
      emit(LocationLoading());
      final loc = await location.getLocation();
      emit(LocationFetched(loc));
    } catch (e) {
      emit(LocationError("User has not given permission to recieve location."));
      print(e.toString());
    }
  }

// Initial:
//  checkPerms();
// The permission to use location services has been granted for high accuracy.
// granted,

  /// The permission has been granted but for low accuracy. Only valid on iOS 14+.
// grantedLimited,

  /// The permission to use location services has been denied by the user. May
  /// have been denied forever on iOS.
// denied,

  /// The permission to use location services has been denied forever by the
  /// user. No dialog will be displayed on permission request.
// deniedForever
}
