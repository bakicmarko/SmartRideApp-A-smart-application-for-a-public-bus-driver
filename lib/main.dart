import 'package:flutter/material.dart';
import 'package:smart_ride_app/smart_ride_app.dart';

import 'local_storage/storage_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepo.initialize();
  final secureStorage = StorageRepo();
  // await secureStorage.resetStorage();
  final savedUser = await secureStorage.getUser;

  /// print('saved user: ${savedUser.toString()}');
  /// print('isUserLogged: ${savedUser != null}');
  //final bool _isUserLoggedIn = savedUser != null;
  runApp(
    SmartRideApp(
      storageRepo: secureStorage,
      isUserLoggedIn: savedUser != null,
    ),
  );
}
