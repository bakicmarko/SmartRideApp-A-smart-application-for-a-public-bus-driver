import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/providers/driver_list_provider.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as vector_math;
import 'package:custom_info_window/custom_info_window.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/theme/theme.dart';

// Right before you would be doing any loading

class DriversScreen extends StatelessWidget {
  const DriversScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DriversListProvider(context.read()),
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            DeiversGoogleMap(),
            Positioned(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: primaryBlueColor,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class DeiversGoogleMap extends StatefulWidget {
  const DeiversGoogleMap({Key? key}) : super(key: key);

  static const _initalCameraPosotion =
      CameraPosition(target: LatLng(45.800866174693226, 15.971205763215067), zoom: 12.5);

  @override
  State<DeiversGoogleMap> createState() => _DeiversGoogleMapState();
}

class _DeiversGoogleMapState extends State<DeiversGoogleMap> {
  GoogleMapController? _googleMapController;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  @override
  void initState() {
    getBytesFromAsset('assets/images/bus_indicator.png', 64).then((onValue) {
      setState(() {
        customIcon = BitmapDescriptor.fromBytes(onValue);
      });
    });
    super.initState();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    // WidgetsFlutterBinding.ensureInitialized();
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
// make sure to initialize before map loading

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController?.dispose();
    _customInfoWindowController.dispose();
    super.dispose();
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
    double new_x = x / cos(vector_math.radians(y0));

    double foundLongitude = new_x + x0;
    double foundLatitude = y + y0;
    return LatLng(foundLongitude, foundLatitude);
  }

  final Set<Marker> _markers = {};
  final double lat = 45.800866174693226;
  final double lng = 15.971205763215067;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DriversListProvider>();
    provider.state.maybeWhen(
        orElse: () => {debugPrint('FAILLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL')},
        success: (drivers) {
          _fillmarkers(drivers);
        });

    return Stack(
      children: [
        GoogleMap(
          buildingsEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: DeiversGoogleMap._initalCameraPosotion,
          onMapCreated: (controller) => {
            _googleMapController = controller,
            _customInfoWindowController.googleMapController = controller,
          },

          markers: _markers,

          /// markers: Set<Marker>.of(markers.values),
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 80,
          width: 130,
          offset: 30,
        ),
      ],
    );
  }

  void _fillmarkers(List<User> drivers) {
    for (var element in drivers) {
      LatLng position = getLocation(lat, lng, 3000);
      _markers.add(
        Marker(
          markerId: MarkerId('Marker${element.id}'),
          position: position,
          icon: customIcon,
          onTap: () {
            if (_customInfoWindowController.addInfoWindow != null) {
              _customInfoWindowController.addInfoWindow!(
                Material(
                  elevation: elevatedButtonElevation,
                  borderRadius: smallBorderRadius,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: smallBorderRadius),
                    padding: smallAllOutsidePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${element.firstName} ${element.surName}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: mediumBoldWeight, fontSize: 12),
                          ),
                        ),
                        smallestHeightDivideBox,
                        Text(element.phoneNumber, style: Theme.of(context).textTheme.titleSmall),
                        Text(element.phoneNumber, style: Theme.of(context).textTheme.titleSmall),
                        Text(
                          element.email,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                position,
              );
            }
          },
        ),
      );
    }
  }
}
