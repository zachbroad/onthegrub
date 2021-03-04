import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:onthegrubv2/models/truck.dart';
import "dart:convert";

part 'trucks_state.dart';

class TrucksCubit extends Cubit<TrucksState> {
  TrucksCubit() : super(TrucksInitial());

  Future<void> getTrucks() async {
    emit(TrucksLoading());
    final resp = await http.get(Uri.dataFromString("http://localhost:8000/api/trucks/"));
    if (resp.statusCode < 300) {
      emit(TrucksFetched(jsonDecode(resp.body)));
      return Truck.fromJson(jsonDecode(resp.body));
    } else {
      emit(TrucksFetchError("Unable to fetch trucks"));
      throw Exception("Unable to fetch trucks");
    }
  }
}
