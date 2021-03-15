import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthegrubv2/models/truck.dart';
import 'package:onthegrubv2/services/api.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

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
