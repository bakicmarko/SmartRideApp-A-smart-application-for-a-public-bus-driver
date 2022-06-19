import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/models/weather_forcast.dart';
import 'package:smart_ride_app/providers/home_screen_provider.dart';
import 'dart:math';
import 'dart:async';

import 'package:smart_ride_app/theme/theme.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.provider}) : super(key: key);

  HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultHorizontalPadding,
      child: Column(
        children: [
          smallHeightDivideBox,
          const StatusDetail(),
          divider,
          smallHeightDivideBox,
          const RoadConditiondDetails(),
          divider,
          smallHeightDivideBox,
          CabinDetails(),
          mediumHeightDivideBox,
          smallHeightDivideBox,
        ],
      ),
    );
  }
}

class StatusDetail extends StatefulWidget {
  const StatusDetail({Key? key}) : super(key: key);

  @override
  State<StatusDetail> createState() => _StatusDetailState();
}

class _StatusDetailState extends State<StatusDetail> {
  Timer? timer;
  var rng = Random();
  int speed = 30;
  int batteryLife = 80;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle emphText = Theme.of(context).textTheme.bodyMedium!.copyWith(color: importandTextColor);
    if (rng.nextBool()) {
      if (speed < 130) speed += rng.nextInt(5);
      if (rng.nextInt(5) == 4) {
        if (batteryLife > 20) {
          batteryLife -= 1;
        } else {
          batteryLife += 1;
        }
      }
    } else {
      if (speed > 20) speed -= rng.nextInt(5);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Status",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13, fontWeight: FontWeight.normal)),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Speed"), Text("$speed km/h", style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Battery life"), Text("$batteryLife %", style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Battery temperature"), Text("26 °C", style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Consumption"), Text("15 kWh/100 km", style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Distance"), Text("300 km", style: emphText)],
        ),
        smallHeightDivideBox,
      ],
    );
  }
}

class RoadConditiondDetails extends StatefulWidget {
  const RoadConditiondDetails({Key? key}) : super(key: key);

  @override
  State<RoadConditiondDetails> createState() => _RoadConditiondDetailsState();
}

class _RoadConditiondDetailsState extends State<RoadConditiondDetails> {
  Timer? timer;
  final List<String> road = ['Slippery', 'Wet', 'Dry', 'Iced', 'Foggy', 'Idle'];
  final List<String> traffic = ['Dense', 'Stationary', 'Congested', 'Heavy', 'Queuing', 'Idle'];
  final List<String> advisement = [
    'Snow tiers',
    'Fog lights',
    'Pull aside',
    'Drive below limit',
    'Change route',
    'None'
  ];
  final List<String> warnings = ['Roadwork ahead', 'Traffic jam', 'Car crash', 'Closed road', 'None'];

  @override
  void initState() {
    // TODO: implement initState

    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    TextStyle emphText = Theme.of(context).textTheme.bodyMedium!.copyWith(color: importandTextColor);

    var rng = Random();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Road conditions",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13, fontWeight: FontWeight.normal)),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Road"), Text(road.elementAt(rng.nextInt(road.length)), style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Traffic flow"), Text(traffic.elementAt(rng.nextInt(traffic.length)), style: emphText)],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Advisement"),
            Text(advisement.elementAt(rng.nextInt(advisement.length)), style: emphText)
          ],
        ),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Warnings"), Text(warnings.elementAt(rng.nextInt(warnings.length)), style: emphText)],
        ),
        smallHeightDivideBox,
        provider.state.maybeWhen(
          orElse: () => Container(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (weather) {
            return _WeatherForcastView(weather: weather);
          },
        ),
      ],
    );
  }
}

class _WeatherForcastView extends StatelessWidget {
  const _WeatherForcastView({Key? key, required this.weather}) : super(key: key);

  final WeatherForcast weather;

  @override
  Widget build(BuildContext context) {
    return Text(weather.precipitation.toString());
  }
}

class CabinDetails extends StatelessWidget {
  CabinDetails({Key? key}) : super(key: key);

  final double containerSize = defaultButtonHeight * 2.2;
  final BoxDecoration boxDecoration = BoxDecoration(
    color: primaryGreyColor.withOpacity(.4),
    borderRadius: smallBorderRadius,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Cabin",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13, fontWeight: FontWeight.normal)),
        smallHeightDivideBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              // color: Colors.transparent,
              elevation: elevatedButtonElevation / 1.5,
              shadowColor: primaryGreyColor,
              shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
              child: Container(
                height: containerSize,
                width: containerSize,
                decoration: boxDecoration,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("20", style: Theme.of(context).textTheme.displayLarge)),
                        ),
                        Positioned(
                            top: 20,
                            left: containerSize * (2 / 3) - 3,
                            child: Text("°C",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 22, fontWeight: FontWeight.normal))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Material(
              // color: Colors.transparent,
              elevation: elevatedButtonElevation / 1.5,
              shadowColor: primaryGreyColor,
              shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
              child: Container(
                height: containerSize,
                width: containerSize,
                decoration: boxDecoration,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.airline_seat_recline_extra_outlined,
                        color: secondaryTextColor,
                        size: containerSize / 3,
                      ),
                      Text(
                        "21",
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              // color: Colors.transparent,
              elevation: elevatedButtonElevation / 1.5,
              shadowColor: primaryGreyColor,
              shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
              child: Container(
                height: containerSize,
                width: containerSize,
                decoration: boxDecoration,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.airline_seat_recline_extra_outlined,
                        color: Colors.transparent,
                        size: containerSize / 3,
                      ),
                      Text(
                        "30",
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
