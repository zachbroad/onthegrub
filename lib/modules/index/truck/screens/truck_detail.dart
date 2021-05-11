import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onthegrubv2/modules/index/truck/bloc/trucks_cubit.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';
import 'package:onthegrubv2/modules/index/truck/screens/truck_detail_fetched.dart';

class TruckDetailScreen extends StatelessWidget {
  final int truckId;

  const TruckDetailScreen({Key key, this.truckId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TruckDetailCubit>(
      create: (_) => TruckDetailCubit(this.truckId),
      child: BlocBuilder<TruckDetailCubit, TrucksState>(builder: (
        context,
        state,
      ) {
        if (state is TrucksInitial) {
          return Scaffold(
            appBar: AppBar(
              title: Text("'"),
            ),
            body: Container(
              child: Column(
                children: [
                  Text(state.toString()),
                  Text(this.truckId.toString()),
                ],
              ),
            ),
          );
        }
        if (state is TrucksLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Text(""),
            ),
            body: SpinKitSquareCircle(
              color: Colors.white,
              size: 50.0,
            ),
          );
        }
        if (state is TruckFetched) {
          return Scaffold(
              // appBar: AppBar(
              //   title: Text(state.truck.title),
              // ),
              body: TruckDetailFetchedScreen(context, state));
        }

        return Scaffold(
            appBar: AppBar(
              title: Text("Error: ${state}"),
            ),
            body: Container(child: Text("Error: ${state}")));
      }),
    );
  }
}
