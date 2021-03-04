import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:onthegrubv2/models/truck.dart';
import "dart:convert";

import 'package:onthegrubv2/services/api.dart';

part 'trucks_state.dart';

class TrucksCubit extends Cubit<TrucksState> {
  TrucksCubit() : super(TrucksInitial());

  Future<void> getTrucks() async {
    emit(TrucksLoading());

    var response = await APIService.fetchTrucksList();
    var results = response["results"];

    var _trucks = <Truck>[];

    for (Map<String, dynamic> truck in results) {
      Truck t = Truck.fromJson(truck);
      _trucks.add(t);
    }

    emit(TrucksFetched(trucks: _trucks));

//    if (resp.statusCode < 300) {
//      emit(TrucksFetched(jsonDecode(resp.body)));
//      return Truck.fromJson(jsonDecode(resp.body));
//    } else {
//      emit(TrucksFetchError("Unable to fetch trucks"));
//      throw Exception("Unable to fetch trucks");
//    }
  }
}
