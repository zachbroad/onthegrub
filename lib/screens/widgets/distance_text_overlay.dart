import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onthegrub/blocs/location_bloc.dart';
import 'package:onthegrub/models/truck.dart';
import 'package:provider/provider.dart';

class TruckDistanceText extends StatelessWidget {
  final Truck truck;

  const TruckDistanceText({Key key, @required this.truck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng userLocation = Provider.of<LocationBloc>(context).userLocation;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.black38),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "${truck.distanceAway(userLocation) != null ? truck.distanceAway(userLocation).toStringAsFixed(2) : null} mi",
            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
