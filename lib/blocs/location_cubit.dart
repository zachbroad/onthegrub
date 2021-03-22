import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location _location;
  LocationCubit(this._location) : super(LocationInitial());

  Future<void> requestPermission() async {
    try {
      emit(LocationPermissionLoading());
      final status = await _location.requestPermission();
      emit(LocationPermission(status));
    } catch (e) {
      emit(LocationError(e.toString()));
      print(e.toString());
    }
  }

  Future<void> getLocation() async {
    try {
      emit(LocationLoading());
      final location = await _location.getLocation();
      emit(LocationFetched(location));
    } catch (e) {
      emit(LocationError("User has not given permission to recieve location."));
      print(e.toString());
    }
  }

  Location get location => _location;

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
