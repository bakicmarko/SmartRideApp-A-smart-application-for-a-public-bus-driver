import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/weather_forcast.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'package:smart_ride_app/providers/request_provider.dart';

class HomeProvider extends RequestProvider<WeatherForcast> {
  final NetworkRepo _repo;
  final StorageRepo _storage;
  HomeProvider(this._repo, this._storage) {
    _readSavedUser();
    fetchWeather();
  }

  User? _savedUser;
  User? get getUser => _savedUser;

  Future<void> _readSavedUser() async {
    _savedUser = await _storage.getUser;
    notifyListeners();
  }

  void fetchWeather() async {
    if (_savedUser == null) await _readSavedUser();
    executeRequest(requestBuilder: () => _repo.fetchWeatherForcast(_savedUser as User));
  }

  Future<void> logOutUser() async {
    await _storage.resetStorage();
  }
}
