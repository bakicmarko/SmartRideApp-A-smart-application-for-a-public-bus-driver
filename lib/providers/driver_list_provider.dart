import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'request_provider.dart';

class DriversListProvider extends RequestProvider<List<User>> {
  final NetworkRepo _repo;
  DriversListProvider(this._repo) {
    _getDrivers();
  }

  void _getDrivers() {
    executeRequest(requestBuilder: () => _repo.getDrivers());
  }
}
