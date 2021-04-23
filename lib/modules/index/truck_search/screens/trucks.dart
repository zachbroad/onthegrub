import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/modules/index/truck_search/bloc/trucks_cubit.dart';
import 'package:onthegrubv2/modules/index/truck_search/models/truck.dart';

class TruckSearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TruckSearchScreenState();
  }
}

class TruckListItem extends StatelessWidget {
  final Truck truck;

  TruckListItem({this.truck});

  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(this.truck.title),
        Text(this.truck.address),
      ]),
    );
  }
}

class _TruckSearchScreenState extends State<TruckSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrucksCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Truck Finder")),
        body: BlocBuilder<TrucksCubit, TrucksState>(
          builder: (context, state) {
            if (state is TrucksInitial) {
              return Container(
                  child: Column(
                children: [
                  Text("Trucks Init"),
                  TextButton(
                    child: Text("Load"),
                    onPressed: (() => context.read<TrucksCubit>().getTrucks()),
                  )
                ],
              ));
            }
            if (state is TrucksLoading) {
              return Container(child: Text("Loading..."));
            }
            if (state is TrucksFetched) {
              return Container(
                  child: Column(
                children: [...state.trucks.map((e) => TruckListItem(truck: e))],
              ));
            }
            if (state is TrucksFetchError) {
              return Container(child: Text("Error:  + $state.error"));
            }

            return Text("??? - $state");
          },
        ),
      ),
    );
  }
}
