import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/models/request.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/providers/home_screen_provider.dart';
import 'package:smart_ride_app/screens/details_screen.dart';
import 'package:smart_ride_app/screens/nav_bar.dart';
import 'package:smart_ride_app/screens/show_route_pop_up.dart';
import 'package:smart_ride_app/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(context.read(), context.read()),
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenContent> {
  final bottomScheetController = DraggableScrollableController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    double topOffset = MediaQuery.of(context).size.height * (1 - provider.initialChildSize) - 105;
    debugPrint(topOffset.toString());
    EdgeInsets allPading =
        const EdgeInsets.symmetric(horizontal: defaultPaddingValue, vertical: defaultPaddingValue + 5);

    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      drawer: NavBar(openDetailsSheet: anim),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMapsEmpty(allPading: allPading, topOffset: topOffset, scaffoldKey: scaffoldKey),

            /// Padding(
            ///   padding: allPading,
            ///   child: Row(
            ///     mainAxisSize: MainAxisSize.max,
            ///     children: [
            ///       ElevatedButton(
            ///         onPressed: () => {scaffoldKey.currentState!.openDrawer()},
            ///         style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            ///               fixedSize: MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
            ///               minimumSize: MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
            ///               shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: defaultBorderRadius)),
            ///               padding: MaterialStateProperty.all(EdgeInsets.zero),
            ///             ),
            ///         child: const Icon(Icons.menu),
            ///       ),
            ///       defaultWidthDivideBox,
            ///       Expanded(
            ///         child: Material(
            ///           elevation: elevatedButtonElevation,
            ///           shadowColor: primaryGreyColor,
            ///           shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
            ///           child: SizedBox(
            ///             height: defaultButtonHeight,
            ///             child: TextFormField(
            ///               controller: _searchTextController,
            ///               textAlignVertical: TextAlignVertical.bottom,
            ///               decoration: InputDecoration(
            ///                 prefixIcon: const Icon(Icons.search),
            ///                 hintText: "Search location",
            ///                 hintStyle: Theme.of(context).textTheme.bodyMedium,
            ///                 filled: true,
            ///                 fillColor: secondaryTextColor,
            ///                 border: const OutlineInputBorder(
            ///                     borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
            ///               ),
            ///               onFieldSubmitted: (input) async {
            ///                 LatLng placeLocation = await provider.findPlace(input);

            ///               },
            ///             ),
            ///           ),
            ///         ),
            ///       ),
            ///     ],
            ///   ),
            /// ),
            provider.isDriving && provider.drivingMode[0] == true
                ? Positioned(
                    top: topOffset,
                    child: Padding(
                      padding: allPading,
                      child: ElevatedButton(
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                Center(child: ShowRoutePopUp(currentStation: Random().nextInt(6) + 1)),
                          )
                        },
                        child: const Text('Show route'),
                      ),
                    ),
                  )
                : const SizedBox(),
            provider.isDriving == false && provider.drivingMode[1] == true
                ? Positioned(
                    top: topOffset,
                    right: defaultButtonHeight + 5,
                    child: Padding(
                      padding: allPading,
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                            ),
                        onPressed: () async {
                          Request request = await provider.getRequestDrive();
                          showModalBottomSheet(
                            context: context,
                            elevation: elevatedButtonElevation,
                            builder: (context) => RequestRide(provider: provider, request: request),
                          );
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  )
                : const SizedBox(),
            DraggableScrollableSheet(
              controller: bottomScheetController,
              initialChildSize: provider.initialChildSize,
              minChildSize: provider.initialChildSize,
              snap: true,
              snapSizes: const [0.9],
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(color: primaryGreyColor, spreadRadius: .5, blurRadius: 5, offset: Offset(0, -0.5))
                      ]),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: const CustomScrollViewContent(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void anim() {
    bottomScheetController.animateTo(0.9, duration: const Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
    debugPrint("callback done");
  }
}

class RequestRide extends StatelessWidget {
  const RequestRide({Key? key, required this.provider, required this.request}) : super(key: key);

  final HomeProvider provider;
  final Request request;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.3,
      decoration: const BoxDecoration(
        color: primaryBlueColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: defaultAllOutsidePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => {},
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                            shape: MaterialStateProperty.all(
                                const CircleBorder(side: BorderSide(color: primaryBlueColor))),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            minimumSize: MaterialStateProperty.all(iconSizeSmall),
                            maximumSize: MaterialStateProperty.all(iconSize),
                          ),
                      child: const Icon(Icons.person, color: primaryGreyColor, size: 45),
                    ),
                    smallestHeightDivideBox,
                    Row(
                      children: [
                        Text(request.rating.toString(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal)),
                        smallestWidthDivideBox,
                        const Icon(Icons.star, color: Colors.white, size: 17),
                      ],
                    )
                  ],
                ),
                mediumWidthDivideBox,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${request.firstName} ${request.surName}', style: Theme.of(context).textTheme.displayMedium),
                    smallestHeightDivideBox,
                    Text(request.email,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal)),
                    smallestHeightDivideBox,
                    Text(request.phoneNumber,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.white,
          ),
          Padding(
            padding: defaultAllOutsidePadding,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, color: Colors.white, size: 20),
                      smallWidthDivideBox,
                      smallWidthDivideBox,
                      Text(request.destination,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                  smallestHeightDivideBox,
                  Row(
                    children: [
                      const Icon(Icons.schedule_outlined, color: Colors.white, size: 20),
                      smallWidthDivideBox,
                      smallWidthDivideBox,
                      Text('${request.travelTime.toString()} min',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.normal)),
                    ],
                  ),
                  smallHeightDivideBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: smallBorderRadius)),
                              backgroundColor: MaterialStateProperty.all(greenColor),
                            ),
                        onPressed: () => {
                          provider.setFlexibleRequest = request,
                          Navigator.of(context).pop(),
                        },
                        child: Text('Accept', style: Theme.of(context).textTheme.displayMedium),
                      ),
                      ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: smallBorderRadius)),
                              backgroundColor: MaterialStateProperty.all(redColor),
                            ),
                        onPressed: () => {
                          provider.setIsDriving = false,
                          Navigator.of(context).pop(),
                        },
                        child: Text('Decline', style: Theme.of(context).textTheme.displayMedium),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomScrollViewContent extends StatefulWidget {
  const CustomScrollViewContent({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewContent> createState() => _CustomScrollViewContentState();
}

class _CustomScrollViewContentState extends State<CustomScrollViewContent> {
  List<bool> isSelected = [true, false];
  bool stopRequested = false;

  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      /// Random().nextInt(2) == 2
      if (Random().nextInt(2) == 1) {
        setState(() {
          stopRequested = !stopRequested;
        });
        debugPrint(stopRequested.toString());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Column(
      children: [
        Container(
          height: 7,
          width: 50,
          decoration: BoxDecoration(color: primaryGreyColor, borderRadius: defaultBorderRadius),
          margin: const EdgeInsets.only(top: 5),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close, color: Colors.transparent, size: defaultButtonHeight * (2 / 3)),
              largeWidthDivideBox,
              Center(
                child: ToggleButtons(
                  isSelected: provider.drivingMode,
                  fillColor: primaryBlueColor,
                  selectedColor: secondaryTextColor,
                  color: primaryTextColor,
                  onPressed: (index) {
                    setState(() {
                      provider.drivingMode[index] = !provider.drivingMode[index];
                      if (index == 0) {
                        // FIXED
                        provider.endDrive();

                        provider.setDrivingMode = 0;
                      } else {
                        // FLEXIBLE
                        provider.endDrive();
                        provider.setDrivingMode = 1;
                      }
                    });
                  },
                  constraints: const BoxConstraints(minWidth: smallButtonWidth, minHeight: smallButtonHeight),
                  borderRadius: smallBorderRadius,
                  children: const [
                    Text("Fixed"),
                    Text("Flexible"),
                  ],
                ),
              ),
              largeWidthDivideBox,
              provider.isDriving
                  ? Icon(
                      Icons.close,
                      color: !stopRequested ? primaryGreyColor : redColor,
                      size: defaultButtonHeight * (2 / 3),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        provider.isDriving ? _RideShortInfo() : Container(),
        provider.isDriving ? divider : Container(),
        DetailsScreen(provider: provider),
        // drive info
        // endbtn
        // together
      ],
    );
  }
}

class _RideShortInfo extends StatelessWidget {
  _RideShortInfo({Key? key}) : super(key: key);

  final Random rnd = Random();

  final List<String> startings = [
    "81538 Shaun Drive",
    "5335 Upton Forge",
    "1212 Annie Lodge",
    "2914 Orlando Bridge",
    "69471 Finn Shoal",
    "415 Osinski Freeway",
    "397 McDermott Mountain",
    "862 Kuhic Pass",
    "09307 Upton Circles",
    "881 Jamel Shores",
    "306 Hegmann Glens",
    "98021 Hermann Street",
  ];

  final List<String> destinations = [
    "50125 Miller Flat",
    "148 Thora River",
    "972 Leila Ferry",
    "99845 Zulauf Expressway",
    "1349 Heller Isle",
    "5770 Wilderman Loop",
    "204 Schaden Land",
    "829 Jaylon Park",
    "59477 Brook Centers",
    "51455 Taurean Mews",
    "98697 Mann Track",
    "023 Emanuel Lodge",
    "558 Rice Walks",
    "64633 Lempi Viaduct",
    "3823 Schoen Wells",
    "603 Elna Court",
    "67957 Rylee Isle",
    "98140 Candelario Mission",
  ];
  final List<String> nextStations = [
    "Maria Village",
    "Riley Extension",
    "Rodriguez Spur",
    "Mohr Ramp",
    "Mraz Hollow",
    "Brayan Drive",
    "Portland",
    "Springfield",
    "Montebello",
    "Emma Springs",
    "Harrisburg",
  ];
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    Request? req = provider.flexibleRequest;

    final String startingLocation = provider.drivingMode[0] == true
        ? startings[rnd.nextInt(startings.length - 2)]
        : req != null
            ? req.start
            : '';
    final String destination = provider.drivingMode[0] == true
        ? destinations[rnd.nextInt(destinations.length - 2)]
        : req != null
            ? req.destination
            : '';

    String nextStation = nextStations[rnd.nextInt(nextStations.length - 2)];
    const double iconSIze = 20;
    return Padding(
      padding: defaultHorizontalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.hail, color: primaryGreyColor, size: iconSIze),
                  const Text('Starting location:  '),
                  Text(
                    startingLocation,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: importandTextColor),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.pin_drop_outlined, color: primaryGreyColor, size: iconSIze),
                  const Text("Destination:  "),
                  Text(
                    destination,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: importandTextColor),
                  )
                ],
              ),
              provider.drivingMode[0] == true
                  ? Row(
                      children: [
                        const Icon(Icons.place_outlined, color: primaryGreyColor, size: iconSIze),
                        const Text("Next station:  "),
                        Text(
                          '$nextStation (${rnd.nextInt(20) + 5} min)',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: importandTextColor),
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
          ElevatedButton(
            onPressed: (() => {provider.endDrive()}),
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.all(redColor),
                  minimumSize:
                      MaterialStateProperty.all(const Size(defaultButtonWidth / 1.2, defaultButtonHeight / 1.1)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallButtonBorderRadius)),
                  ),
                ),
            child: const Text("END"),
          )
        ],
      ),
    );
  }
}

class GoogleMapsEmpty extends StatefulWidget {
  const GoogleMapsEmpty({
    Key? key,
    required this.topOffset,
    required this.allPading,
    required this.scaffoldKey,
  }) : super(key: key);
  final double topOffset;
  final EdgeInsets allPading;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<GoogleMapsEmpty> createState() => _GoogleMapsEmptyState();
}

class _GoogleMapsEmptyState extends State<GoogleMapsEmpty> {
  static const _initalCameraPosotion = CameraPosition(target: LatLng(45.800866174693226, 15.971205763215067), zoom: 13);
  final TextEditingController _searchTextController = TextEditingController();

  GoogleMapController? _googleMapController;
  void animateCamera() {
    _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initalCameraPosotion));
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initalCameraPosotion,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: provider.markers,
          polylines: provider.polylines,
        ),
        Padding(
          padding: widget.allPading,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () => {widget.scaffoldKey.currentState!.openDrawer()},
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      fixedSize: MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                      minimumSize: MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: defaultBorderRadius)),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                child: const Icon(Icons.menu),
              ),
              defaultWidthDivideBox,
              Expanded(
                child: Material(
                  elevation: elevatedButtonElevation,
                  shadowColor: primaryGreyColor,
                  shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
                  child: SizedBox(
                    height: defaultButtonHeight,
                    child: TextFormField(
                      controller: _searchTextController,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search location",
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        filled: true,
                        fillColor: secondaryTextColor,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                      onFieldSubmitted: (input) async {
                        LatLng placeLocation = await provider.findPlace(input);
                        MarkerId markerId = MarkerId(placeLocation.toString());
                        Marker placeMarker = Marker(
                            markerId: markerId,
                            infoWindow: InfoWindow(title: _searchTextController.text),
                            position: placeLocation,
                            onTap: () => {
                                  provider.removeMarker(markerId),
                                });
                        _searchTextController.clear();

                        _googleMapController?.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(target: placeLocation, zoom: 15)));
                        provider.addMarker(placeMarker);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: widget.topOffset,
          right: 0,
          child: Padding(
            padding: widget.allPading,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    minimumSize: MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
              onPressed: () => {
                _googleMapController?.animateCamera(
                  CameraUpdate.newCameraPosition(_initalCameraPosotion),
                ),
              },
              child: const Icon(Icons.center_focus_weak, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
