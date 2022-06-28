import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  bool isDriving = false;
  double minBottomSheet = 0.2;
  double initialChildSize = 0.2;

  @override
  Widget build(BuildContext context) {
    if (!isDriving) {
      setState(() {
        minBottomSheet = 0.1;
        initialChildSize = 0.1;
      });
    }
    double topOffset = MediaQuery.of(context).size.height * (1 - initialChildSize) - 105;
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
            GoogleMapsEmpty(allPading: allPading, topOffset: topOffset),
            Padding(
              padding: allPading,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () => {scaffoldKey.currentState!.openDrawer()},
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: topOffset,
              child: Padding(
                padding: allPading,
                child: ElevatedButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (context) => Center(child: ShowRoutePopUp(currentStation: Random().nextInt(6) + 1)),
                    )
                  },
                  child: const Text('Show route'),
                ),
              ),
            ),
            DraggableScrollableSheet(
              controller: bottomScheetController,
              initialChildSize: initialChildSize,
              minChildSize: minBottomSheet,
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
                    child: CustomScrollViewContent(isDriving: isDriving),
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

class CustomScrollViewContent extends StatefulWidget {
  const CustomScrollViewContent({Key? key, required this.isDriving}) : super(key: key);

  final bool isDriving;

  @override
  State<CustomScrollViewContent> createState() => _CustomScrollViewContentState();
}

class _CustomScrollViewContentState extends State<CustomScrollViewContent> {
  List<bool> isSelected = [true, false];
  bool stopRequested = false;

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
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
    // TODO: implement dispose
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
                  isSelected: isSelected,
                  fillColor: primaryBlueColor,
                  selectedColor: secondaryTextColor,
                  color: primaryTextColor,
                  onPressed: (index) {
                    setState(() {
                      isSelected[index] = !isSelected[index];
                      if (index == 0) {
                        // FIXED
                        isSelected[index + 1] = !isSelected[index + 1];
                      } else {
                        // FLEXIBLE
                        isSelected[index - 1] = !isSelected[index - 1];
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
              Icon(Icons.close,
                  color: !stopRequested ? primaryGreyColor : redColor, size: defaultButtonHeight * (2 / 3)),
            ],
          ),
        ),
        widget.isDriving ? const _RideShortInfo() : Container(),
        widget.isDriving ? divider : Container(),
        DetailsScreen(provider: provider),
        // drive info
        // endbtn
        // together
      ],
    );
  }
}

class _RideShortInfo extends StatelessWidget {
  const _RideShortInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultHorizontalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [
              Text("Starting location:  AK Zagreb"),
              smallestHeightDivideBox,
              Text("Starting location:  AK Zagreb"),
              smallestHeightDivideBox,
              Text("Starting location:  AK Zagreb"),
              smallestHeightDivideBox,
            ],
          ),
          ElevatedButton(
            onPressed: (() => {}),
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
  }) : super(key: key);
  final double topOffset;
  final EdgeInsets allPading;
  @override
  State<GoogleMapsEmpty> createState() => _GoogleMapsEmptyState();
}

class _GoogleMapsEmptyState extends State<GoogleMapsEmpty> {
  static const _initalCameraPosotion = CameraPosition(target: LatLng(45.800866174693226, 15.971205763215067), zoom: 13);

  GoogleMapController? _googleMapController;
  void animateCamera() {
    _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(_initalCameraPosotion));
  }

  final Marker _origin = const Marker(
    markerId: MarkerId('Origin'),
    infoWindow: InfoWindow(title: 'Origin'),
    position: LatLng(45.800866174693226, 15.971205763215067),
  );
  final Marker _destination = const Marker(
    markerId: MarkerId('Destination'),
    infoWindow: InfoWindow(title: 'Destination'),
    position: LatLng(45.786009602285, 15.947999289604418),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initalCameraPosotion,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if (_origin != null) _origin as Marker,
            if (_destination != null) _destination as Marker,
          },
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
