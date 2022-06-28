import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/login_info.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:smart_ride_app/models/request.dart';
import 'package:smart_ride_app/models/route.dart' as custom_route;
import 'package:smart_ride_app/models/weather_forcast.dart';
import 'package:smart_ride_app/networking/network_error_interceptor.dart';
import 'api_constants.dart';

class NetworkRepo {
  final StorageRepo _storageRepo;
  late final Dio _dio;

  NetworkRepo(this._storageRepo) {
    _dio = Dio(BaseOptions(baseUrl: ApiConstants.BASE_URL));
    _dio.interceptors.add(ErrorExtractorInterceptor());
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

    list.forEach((element) {
      Map m = element as Map;
      listOfIDs.add(m['id'].toString());
    });

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
