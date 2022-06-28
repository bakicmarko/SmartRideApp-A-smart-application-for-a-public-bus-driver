import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'package:smart_ride_app/screens/home_screen.dart';
import 'package:smart_ride_app/screens/login_screen.dart';
import 'theme/theme.dart';

class SmartRideApp extends StatelessWidget {
  const SmartRideApp({Key? key, required this.storageRepo, required this.isUserLoggedIn}) : super(key: key);

  final StorageRepo storageRepo;
  final bool isUserLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageRepo>(create: ((context) => storageRepo)),
        Provider(create: (context) => NetworkRepo(context.read())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: isUserLoggedIn ? HomeScreen() : LogInScreen(),
      ),
    );
  }
}
