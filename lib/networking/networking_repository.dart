import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/login_info.dart';
import 'package:dio/dio.dart';
import 'package:smart_ride_app/models/request.dart';
import 'package:smart_ride_app/models/route.dart' as custom_route;
import 'package:smart_ride_app/models/weather_forcast.dart';
import 'package:smart_ride_app/networking/network_error_interceptor.dart';
import 'api_constants.dart';
import 'package:smart_ride_app/.env.dart';

class NetworkRepo {
  final StorageRepo _storageRepo;
  late final Dio _dio;
  late final Dio _dioGooglePlaces;
  late final Dio _dioGooglePlaces2;
  final String _findPlaceUrl = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?';
  final String _findPlaceDetailsUrl = 'https://maps.googleapis.com/maps/api/place/details/json?';

  NetworkRepo(this._storageRepo) {
    _dio = Dio(BaseOptions(baseUrl: ApiConstants.BASE_URL));
    _dio.interceptors.add(ErrorExtractorInterceptor());

    _dioGooglePlaces = Dio(BaseOptions(baseUrl: _findPlaceUrl));
    _dioGooglePlaces.interceptors.add(ErrorExtractorInterceptor());

    _dioGooglePlaces2 = Dio(BaseOptions(baseUrl: _findPlaceDetailsUrl));
    _dioGooglePlaces2.interceptors.add(ErrorExtractorInterceptor());
  }

  Future<LatLng> findPlace(String searchName) async {
    try {
      final response = await _dioGooglePlaces.get('input=$searchName&inputtype=textquery&key=$APIKey');

      var placeID = response.data['candidates'][0]['place_id'];
      debugPrint(placeID);

      final getPlaceResponse = await _dioGooglePlaces2.get('place_id=$placeID&key=$APIKey');
      debugPrint(getPlaceResponse.data.toString());
      final result = getPlaceResponse.data['result'] as Map<String, dynamic>;

      final double lat = result['geometry']['location']['lat'];
      final double lng = result['geometry']['location']['lng'];

      return LatLng(lat, lng);
    } catch (e) {
      debugPrint(e.toString());
      return const LatLng(45.800866174693226, 15.971205763215067);
    }
  }

  Future<User> signInUser(LogInInfo loginInfo) async {
    final response = await _dio.get('/drivers/${loginInfo.email}/profile/${loginInfo.email}');
    final user = User.fromJson(response.data);

    await _storageRepo.storeUserJson(user, 'user');

    return user;
  }

  Future<List<User>> getDrivers() async {
    // just id of drivers
    final response = await _dio.get('/drivers');

    List list = response.data as List;

    List<String> listOfIDs = [];

    for (var element in list) {
      Map m = element as Map;
      listOfIDs.add(m['id'].toString());
    }

    List<User> drivers = [];

    for (int id = 5; id < 15; id++) {
      final response2 = await _dio.get('/drivers/${id.toString()}/profile/${id.toString()}');
      final user = User.fromJson(response2.data);
      drivers.add(user);
    }

    return drivers;
  }

  Future<List<Request>> getRequests(User user) async {
    final responseDrivers = await _dio.get('/drivers');

    List listDrivers = responseDrivers.data as List;

    List<String> listOfIDs = [];

    for (var element in listDrivers) {
      Map m = element as Map;
      listOfIDs.add(m['id'].toString());
    }

    final random = Random();
    List<Request> requestsList = [];

    for (int i = 0; i < 10; i++) {
      String id = listOfIDs[random.nextInt(listOfIDs.length - 10)];
      debugPrint('/drivers/$id/reviews/$id');
      final responseRequest = await _dio.get('/drivers/$id/reviews/$id');
      final request = Request.fromJson(responseRequest.data);
      requestsList.add(request);
    }

    return requestsList;
  }

  Future<Request> getOneRequest() async {
    int id = Random().nextInt(30) + 1;
    final responseRequest = await _dio.get('/drivers/$id/reviews/$id');
    final request = Request.fromJson(responseRequest.data);

    return request;
  }

  Future<custom_route.Route> getRoute() async {
    User? user = await _storageRepo.getUser;
    final response = await _dio.get('/drivers/${user!.id}/route/${user.id}');

    final route = custom_route.Route.fromJson(response.data);

    return route;
  }

  Future<WeatherForcast> fetchWeatherForcast(User user) async {
    final response = await _dio.get('/drivers/${user.id}/wather_forcast/${user.id}');
    final weather = WeatherForcast.fromJson(response.data);

    return weather;
  }
}
