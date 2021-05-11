part of 'trucks_cubit.dart';

abstract class TrucksState extends Equatable {
  const TrucksState();
}

class TrucksInitial extends TrucksState {
  @override
  List<Object> get props => [];
}

class TrucksLoading extends TrucksState {
  @override
  List<Object> get props => [];
}

class TrucksFetchError extends TrucksState {
  final String error;

  TrucksFetchError({this.error});

  @override
  List<Object> get props => [error];
}

class TruckFetched extends TrucksState {
  final Truck truck;

  TruckFetched({this.truck});

  @override
  List<Object> get props => [truck];
}

class TrucksFetched extends TrucksState {
  final List<Truck> trucks;

  TrucksFetched({this.trucks});

  @override
  List<Object> get props => [trucks];
}
