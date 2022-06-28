import 'package:flutter/material.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/route.dart' as custom_route;
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'request_provider.dart';

class RouteProvider extends RequestProvider<custom_route.Route> {
  final NetworkRepo _repo;
  RouteProvider(this._repo) {
    _getRoute();
  }

  void _getRoute() {
    executeRequest(requestBuilder: () => _repo.getRoute());
  }
}
