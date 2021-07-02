import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onthegrubv2/modules/index/truck/bloc/trucks_cubit.dart';
import 'package:onthegrubv2/modules/index/truck/models/truck.dart';
import 'package:onthegrubv2/modules/index/truck/widgets/truck_list_item.dart';
import 'package:onthegrubv2/modules/index/truck/widgets/truck_search_map.dart';

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
  final TextEditingController search = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider<TrucksCubit>(
      create: (_) {
        var tc = TrucksCubit();
        tc.getTrucks();
        return tc;
      },
      child: Scaffold(
        // appBar: AppBar(title: Text("OnTheGrub")),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: PageScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: BlocBuilder<TrucksCubit, TrucksState>(builder: (
              context,
              state,
            ) {
              if (state is TrucksFetched) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
                      child: Text(
                        "Find food trucks near you",
                        style: Theme.of(context).textTheme.headline1.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                          suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 280, child: TruckSearchMap()),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.map,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Trucks',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Container(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.trucks.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return TruckListItemWidget(
                            truck: state.trucks.elementAt(index),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state is TrucksInitial)
                return Column(
                  children: [
                    Text("Trucks Init"),
                    TextButton(
                      child: Text("Load"),
                      onPressed: (() => context.read<TrucksCubit>().getTrucks()),
                    )
                  ],
                );
              if (state is TrucksLoading) return Text("Loading...");
              if (state is TrucksFetchError) return Text("Error:  + $state.error");
              return Text("??? - $state");
            }),
          ),
        ),
      ),
    );
  }
}
