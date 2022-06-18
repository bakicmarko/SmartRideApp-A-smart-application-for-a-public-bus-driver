import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/login_info.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';

import 'request_provider.dart';

class LogInProvider extends RequestProvider<User> {
  final NetworkRepo _repo;
  LogInProvider(this._repo);

  void signInUser(LogInInfo info) {
    executeRequest(requestBuilder: () => _repo.signInUser(info));
  }
}
