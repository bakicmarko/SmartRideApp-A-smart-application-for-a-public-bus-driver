import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/login_info.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
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

  Future<User> signInUser(LogInInfo login_info) async {
    final response = await _dio.get('/drivers/${login_info.email}/profile/${login_info.email}');
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

  Future<WeatherForcast> fetchWeatherForcast(User user) async {
    final response = await _dio.get('/drivers/${user.id}/wather_forcast/1');
    final weather = WeatherForcast.fromJson(response.data);

    return weather;
  }
}
