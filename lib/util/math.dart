import 'dart:math' show pi;
import 'dart:math';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class Math {
  static double degToRad(num deg) => deg * (pi / 180.0);

  static double radToDeg(num rad) => rad * (180.0 / pi);

  static milesToFeet(num miles) => (miles * 5280);

  static LatLng midpointBetween(LatLng pointA, LatLng pointB) {
    return LatLng((pointA.latitude + pointB.latitude) / 2, (pointA.longitude + pointB.longitude) / 2);
  }

  static double distanceBetween(x1, y1, x2, y2) {
    // earth radius in meters
    double radius = 6371000.0;
    double phi_1 = Math.degToRad(x1);
    double phi_2 = Math.degToRad(x2);

    double deltaPhi = Math.degToRad(x2 - x1);
    double deltaLambda = Math.degToRad(y2 - y1);

    double a = pow(sin(deltaPhi / 2.0), 2) + cos(phi_1) * cos(phi_2) * pow(sin(deltaLambda / 2.0), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double meters = radius * c; // output distance in meters
    double miles = meters / 1609;

    return miles;
  }
}
