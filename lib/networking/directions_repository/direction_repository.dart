import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:smart_ride_app/.env.dart';
import 'package:smart_ride_app/theme/theme.dart';

class DriectionRepository {
  PolylinePoints polylinePoints = PolylinePoints();

  Future<Polyline?> getPolyline(LatLng start, LatLng end) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult response = await polylinePoints.getRouteBetweenCoordinates(
      APIKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
      travelMode: TravelMode.driving,
    );

    if (response.points.isNotEmpty) {
      for (var point in response.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      return Polyline(
          polylineId: PolylineId('${start.toString()} ${end.toString()}'),
          points: polylineCoordinates,
          width: 3,
          color: primaryBlueColor);
    } else {
      debugPrint(response.errorMessage);
      return null;
    }
  }
}
