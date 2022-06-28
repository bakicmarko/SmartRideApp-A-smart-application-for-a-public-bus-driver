import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smart_ride_app/models/request.dart';
import 'package:smart_ride_app/networking/directions_repository/direction_repository.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/local_storage/storage_repo.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/weather_forcast.dart';
import 'package:smart_ride_app/networking/networking_repository.dart';
import 'package:smart_ride_app/providers/request_provider.dart';

class HomeProvider extends RequestProvider<WeatherForcast> {
  final NetworkRepo _repo;
  final StorageRepo _storage;
  final DriectionRepository _derectionRepo = DriectionRepository();
  HomeProvider(this._repo, this._storage) {
    _loadCustomMarkerIcons();
    _readSavedUser();
    fetchWeather();
  }

  double _minBottomSheet = 0.1;
  double get minBottomSheet => _minBottomSheet;
  set setMinBottomSheet(double d) => {
        _minBottomSheet = d,
        notifyListeners(),
      };
  double _initialChildSize = 0.1;
  double get initialChildSize => _initialChildSize;
  set setInitialChildSize(double d) => {
        _initialChildSize = d,
        notifyListeners(),
      };

  User? _savedUser;
  User? get getUser {
    if (_savedUser == null) {
      _readSavedUser();
    }
    return _savedUser;
  }

  void endDrive() {
    _markers.clear();
    _polylines.clear();
    setIsDriving = false;
    setFlexibleRequest = null;
    notifyListeners();
  }

  Future<Request> getRequestDrive() async {
    return await _repo.getOneRequest();
  }

  Request? _flexibleRequest;
  get flexibleRequest => _flexibleRequest;
  set setFlexibleRequest(Request? req) {
    _flexibleRequest = req;
    if (req != null) {
      setDrivingMode = 1;
      setIsDriving = true;
      _markersFlexible(req);
    }
    notifyListeners();
  }

  List<bool> _isSelected = [true, false];
  List<bool> get drivingMode => _isSelected;
  set setDrivingMode(int index) => {
        if (index == 0)
          {
            _isSelected = [true, false],
            setIsDriving = true,
            _polylines.clear(),
            _markers.clear(),
            _markersFixed(),
          }
        else if (index == 1)
          {
            _polylines.clear(),
            _markers.clear(),
            _isSelected = [false, true],
          }
        else
          {
            debugPrint('Wrong driving mode index!!!'),
          },
        notifyListeners(),
      };

  BitmapDescriptor _customIconBus = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _customIconPerson = BitmapDescriptor.defaultMarker;

  bool _isDriving = false;
  bool get isDriving => _isDriving;
  set setIsDriving(bool flag) => {
        _isDriving = flag,
        if (flag)
          {
            _initialChildSize = 0.22,
            _minBottomSheet = 0.22,
          }
        else
          {
            _initialChildSize = 0.1,
            _minBottomSheet = 0.1,
          },
        notifyListeners(),
      };

  LinkedHashSet<Marker> _markers = LinkedHashSet<Marker>();
  LinkedHashSet<Marker> get markers => _markers;

  final double lat = 45.800866174693226;
  final double lng = 15.971205763215067;

  Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  void _markersFlexible(Request request) async {
    LinkedHashSet<Marker> newMarkers = LinkedHashSet<Marker>();
    Set<Polyline> newPolylines = {};

    Marker markerLocation = Marker(
      markerId: const MarkerId('Location'),
      infoWindow: const InfoWindow(title: 'Current location'),
      icon: _customIconBus,
      position: getLocation(lat, lng, 30),
    );
    Marker markerStart = Marker(
      markerId: const MarkerId('Start'),
      infoWindow: const InfoWindow(title: 'Starting location'),
      icon: _customIconPerson,
      position: getLocation(lat, lng, 300),
    );
    Marker markerDestination = Marker(
      markerId: const MarkerId('Destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarker,
      position: getLocation(lat, lng, 1500),
    );

    newMarkers.add(markerLocation);
    newMarkers.add(markerStart);
    newMarkers.add(markerDestination);

    var markersIterator = newMarkers.iterator;
    if (markersIterator.moveNext()) {
      Marker first = markersIterator.current;
      while (markersIterator.moveNext()) {
        Marker second = markersIterator.current;
        Polyline? poly = await _derectionRepo.getPolyline(first.position, second.position);
        if (poly != null) {
          newPolylines.add(poly);
        } else {
          debugPrint('Polyline null');
        }
        first = second;
      }
    }
    _markers = newMarkers;
    _polylines = newPolylines;
    notifyListeners();
  }

  void _markersFixed() async {
    /// _markers.clear();
    /// notifyListeners();
    LinkedHashSet<Marker> newMarkers = LinkedHashSet<Marker>();
    Set<Polyline> newPolylines = {};
    Random rnd = Random();
    int max = 5;
    for (int i = 0; i <= max; i++) {
      String title = 'Station $i: ${rnd.nextInt(15) + 5} min';
      if (i == 0) title = 'Start: ${rnd.nextInt(2) + 5} min';
      if (i == max) title = 'Destination: ${rnd.nextInt(35) + 5} min';
      Marker first = Marker(
        markerId: MarkerId('Marker$i'),
        infoWindow: InfoWindow(title: title),
        position: getLocation(lat, lng, 3000),
        icon: i != 0 ? BitmapDescriptor.defaultMarker : _customIconBus,
      );

      newMarkers.add(first);
    }
    var markersIterator = newMarkers.iterator;
    if (markersIterator.moveNext()) {
      Marker first = markersIterator.current;
      while (markersIterator.moveNext()) {
        Marker second = markersIterator.current;
        Polyline? poly = await _derectionRepo.getPolyline(first.position, second.position);
        if (poly != null) {
          newPolylines.add(poly);
        } else {
          debugPrint('Polyline null');
        }
        first = second;
      }
    }

    _markers = newMarkers;
    _polylines = newPolylines;
    notifyListeners();
  }

  void _loadCustomMarkerIcons() {
    getBytesFromAsset('assets/images/bus_indicator.png', 64).then((onValue) {
      _customIconBus = BitmapDescriptor.fromBytes(onValue);
    });
    getBytesFromAsset('assets/images/person_pin_icon.png', 64).then((onValue) {
      _customIconPerson = BitmapDescriptor.fromBytes(onValue);
    });
    notifyListeners();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    // WidgetsFlutterBinding.ensureInitialized();
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  LatLng getLocation(double x0, double y0, int radius) {
    Random random = Random();

    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000.0;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t);

    // Adjust the x-coordinate for the shrinking of the east-west distances
    double newX = x / cos(vector_math.radians(y0));

    double foundLongitude = newX + x0;
    double foundLatitude = y + y0;
    return LatLng(foundLongitude, foundLatitude);
  }

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
