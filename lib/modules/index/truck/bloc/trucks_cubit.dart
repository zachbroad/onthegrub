import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';
import 'package:onthegrubv2/utils/services/rest_api_service.dart';

part 'trucks_state.dart';

class TrucksCubit extends Cubit<TrucksState> {
  TrucksCubit() : super(TrucksInitial());

  Future<void> getTrucks() async {
    emit(TrucksLoading());

    // TODO: APIService to repo
    var response = await APIService.fetchTrucksList();
    var results = response["results"];

    var trucks = <Truck>[];

    for (Map<String, dynamic> truck in results) {
      Truck t = Truck.fromJson(truck);
      trucks.add(t);
    }

    emit(TrucksFetched(trucks: trucks));

//    if (resp.statusCode < 300) {
//      emit(TrucksFetched(jsonDecode(resp.body)));
//      return Truck.fromJson(jsonDecode(resp.body));
//    } else {
//      emit(TrucksFetchError("Unable to fetch trucks"));
//      throw Exception("Unable to fetch trucks");
//    }
  }

  Future<void> queryTrucks(String query) async {
    emit(TrucksLoading());

    // TODO: Either handle pagination or make this return ALL the trucks when you're searching...
    var response = await APIService.fetchTrucksSearch(query);
    var results = response["results"];
    var trucks = <Truck>[];

    for (Map<String, dynamic> truck in results) {
      Truck t = Truck.fromJson(truck);
      trucks.add(t);
    }
    emit(TrucksFetched(trucks: trucks));
  }
}

class TruckDetailCubit extends Cubit<TrucksState> {
  final int truckId;

  TruckDetailCubit(this.truckId) : super(TrucksInitial()) {
    this.getTruck();
  }

  Future<void> getTruck() async {
    emit(TrucksLoading());
    var response = await APIService.fetchTruckByID(this.truckId);
    Truck truck = Truck.fromJson(response);
    emit(TruckFetched(truck: truck));
  }
}
