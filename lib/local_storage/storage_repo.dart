import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:smart_ride_app/models/User.dart';

class StorageRepo {
  User? _loggedUser;
  late FlutterSecureStorage _secureStorage;

  StorageRepo() {
    _secureStorage = const FlutterSecureStorage();

    /// if (_loggedUser != null) {
    ///   writeUserInStorage(_secureStorage, _loggedUser);
    /// }
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
  }

  final _userJsonBox = Hive.openBox('user');

  Future<void> resetStorage() async {
    await _secureStorage.deleteAll();
    await _userJsonBox.then((value) => value.clear());
    _loggedUser = null;
  }

  Future<Map<String, dynamic>?> readUserJson(String userBoxKey) async {
    final json = (await _userJsonBox).get(userBoxKey);
    return json != null ? jsonDecode(json) : null;
  }

  Future<void> storeUserJson(User user, String userBoxKey) async {
    _loggedUser = user;
    await (await _userJsonBox).put(userBoxKey, jsonEncode(user.toJson()));
  }

  Future<User?> get getUser async {
    // mybe null check for readUserJson
    if (_loggedUser != null) {
      return _loggedUser;
    } else {
      final savedUser = await readUserJson('user');
      if (savedUser != null) _loggedUser = User.fromJson(savedUser);
    }
    return _loggedUser;
  }
}
