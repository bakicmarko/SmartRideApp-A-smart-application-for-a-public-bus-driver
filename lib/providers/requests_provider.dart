import 'package:flutter/material.dart';
import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/login_info.dart';
import 'package:smart_ride_app/models/request.dart';

/// import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'request_provider.dart';

class RequestsProvider extends RequestProvider<List<Request>> {
  final NetworkRepo _repo;
  final StorageRepo _storage;

  User? _user;
  RequestsProvider(this._repo, this._user, this._storage) {
    _getRequests();
  }

  void _getRequests() async {
    _user ??= await _storage.getUser;
    executeRequest(requestBuilder: () => _repo.getRequests(_user as User));
  }
}
