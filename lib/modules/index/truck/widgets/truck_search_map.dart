import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TruckSearchMap extends StatefulWidget {
  @override
  _TruckSearchMapState createState() => _TruckSearchMapState();
}

class _TruckSearchMapState extends State<TruckSearchMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _greaterOrlando = CameraPosition(
    bearing: 0,
    target: LatLng(28.549168, -81.379809),
    tilt: 5,
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _greaterOrlando,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
    );
  }
}
