import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bottomScheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
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
                //GoogleMapsEmpty(),
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
                  initialChildSize: 0.20,
                  minChildSize: 0.15,
                  snap: true,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      /// shadowColor: primaryGreyColor,
                      /// shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: CustomScrollViewContent(),
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
    bottomScheetController.animateTo(
      0.9,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutBack,
    );
  }
}

class ContentEmptyMap extends StatelessWidget {
  ContentEmptyMap({
    Key? key,
  }) : super(key: key);

  final bottomScheetController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
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
                //GoogleMapsEmpty(),
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
                  initialChildSize: 0.20,
                  minChildSize: 0.15,
                  snap: true,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      /// shadowColor: primaryGreyColor,
                      /// shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: CustomScrollViewContent(),
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
    bottomScheetController.animateTo(
      0.9,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutBack,
    );
  }
}

class CustomScrollViewContent extends StatefulWidget {
  const CustomScrollViewContent({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewContent> createState() => _CustomScrollViewContentState();
}

class _CustomScrollViewContentState extends State<CustomScrollViewContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
          height: 50,
          width: 100,
        )
      ],
    );
  }
}

class CustomInnerContent extends StatelessWidget {
  const CustomInnerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12),
        SizedBox(height: 50),
        SizedBox(height: 60),
        SizedBox(height: 24),
        SizedBox(height: 16),
        SizedBox(height: 24),
        SizedBox(height: 16),
        SizedBox(height: 12),
        SizedBox(height: 16),
      ],
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
