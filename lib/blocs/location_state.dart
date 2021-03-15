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

class LocationFetchError extends LocationState {
  final String error;

  LocationFetchError({this.error});

  @override
  List<Object> get props => [error];
}

class LocationFetched extends LocationState {
  final List<int> location;

  LocationFetched({this.location});

  @override
  List<Object> get props => [location];
}
