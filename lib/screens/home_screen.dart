import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/screens/details_screen.dart';
import 'package:smart_ride_app/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bottomScheetController = DraggableScrollableController();
  final isDriving = true;
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
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
            child: Stack(
              children: [
                GoogleMapsEmpty(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPaddingValue, vertical: defaultPaddingValue + 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () => {anim()},
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              fixedSize:
                                  MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                              minimumSize:
                                  MaterialStateProperty.all(const Size(defaultButtonHeight, defaultButtonHeight)),
                              shape:
                                  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: defaultBorderRadius)),
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
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: "Search location",
                                filled: true,
                                fillColor: secondaryTextColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
                      /// shadowColor: primaryGreyColor,
                      /// shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
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
            )),
      ),
    );
  }

  void anim() {
    bottomScheetController.animateTo(0.9, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 7,
          width: 50,
          decoration: BoxDecoration(color: primaryGreyColor, borderRadius: defaultBorderRadius),
          margin: const EdgeInsets.only(top: 5),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5),
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
              const Icon(Icons.close, color: primaryGreyColor, size: defaultButtonHeight * (2 / 3)),
            ],
          ),
        ),
        widget.isDriving ? _RideShortInfo() : Container(),
        widget.isDriving ? divider : Container(),
        DetailsScreen(),
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
            style: Theme.of(context)
                .elevatedButtonTheme
                .style!
                .copyWith(backgroundColor: MaterialStateProperty.all(redColor)),
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
  }) : super(key: key);

  @override
  State<GoogleMapsEmpty> createState() => _GoogleMapsEmptyState();
}

class _GoogleMapsEmptyState extends State<GoogleMapsEmpty> {
  static const _initalCameraPosotion = CameraPosition(target: LatLng(45.800866174693226, 15.971205763215067), zoom: 13);
  GoogleMapController? _googleMapController;
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
    return GoogleMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: _initalCameraPosotion,
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {
        if (_origin != null) _origin as Marker,
        if (_destination != null) _destination as Marker,
      },
    );
  }
}
