part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationPermissionLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationPermission extends LocationState {
  final PermissionStatus status;

  LocationPermission(this.status);

  @override
  List<Object> get props => [status];
}

class LocationError extends LocationState {
  final String error;

  LocationError(this.error);

  @override
  List<Object> get props => [error];
}

class LocationFetched extends LocationState {
  final LocationData locationData;

  LocationFetched(this.locationData);

  @override
  List<Object> get props => [locationData];
}
