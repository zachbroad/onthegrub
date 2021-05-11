import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/modules/index/truck_search/bloc/trucks_cubit.dart';
import 'package:onthegrubv2/modules/index/truck_search/models/truck.dart';
import 'package:onthegrubv2/modules/index/truck_search/widgets/truck_search_map.dart';

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
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => TrucksCubit(),
      child: Container(
        child: BlocBuilder<TrucksCubit, TrucksState>(
          builder: (context, state) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(parent: PageScrollPhysics()),
              child: Column(
                children: [
                  SizedBox(height: size.height * .3, width: size.width, child: TruckSearchMap()),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _search,
                      onFieldSubmitted: (text) {},
                    ),
                  ),
                  Container(
                    height: size.height * .625,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      child: Column(children: [
                        if (state is TrucksInitial)
                          Column(children: [
                            Text("Trucks Init"),
                            TextButton(child: Text("Load"), onPressed: (() => context.read<TrucksCubit>().getTrucks()))
                          ]),
                        if (state is TrucksLoading) Text("Loading..."),
                        if (state is TrucksFetched) Column(children: [...state.trucks.map((e) => TruckListItem(truck: e))]),
                        if (state is TrucksFetchError) Text("Error:  + $state.error"),
                        Text("??? - $state"),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
