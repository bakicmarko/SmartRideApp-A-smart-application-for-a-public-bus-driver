import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/providers/listeners/provider_listener.dart';
import 'package:smart_ride_app/providers/route_provider.dart';
import 'package:smart_ride_app/theme/theme.dart';

class ShowRoutePopUp extends StatelessWidget {
  const ShowRoutePopUp({Key? key, required this.currentStation}) : super(key: key);

  final int currentStation;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RouteProvider(context.read()),
      child: _ShowRouteView(currentStation: currentStation),
    );
  }
}

class _ShowRouteView extends StatelessWidget {
  const _ShowRouteView({Key? key, required this.currentStation}) : super(key: key);

  final int currentStation;

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RouteProvider>(
      listener: ((context, provider) => {
            provider.state.maybeMap(
              orElse: () => Container(),
              failure: (exception) => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(
                    'Failed to fetch requests, $checkIntConnectionErrorM',
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          }),
      child: _ShowRouteContent(currentStation: currentStation),
    );
  }
}

class _ShowRouteContent extends StatelessWidget {
  const _ShowRouteContent({Key? key, required this.currentStation}) : super(key: key);

  final int currentStation;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final provider = context.watch<RouteProvider>();
    return provider.state.maybeWhen(
        orElse: () => Container(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        success: (route) {
          List<String> stations = [];
          stations.add(route.currentStation);
          stations.add(route.station1);
          stations.add(route.station2);
          stations.add(route.station3);
          stations.add(route.station4);
          stations.add(route.station5);
          stations.add(route.station6);
          stations.add(route.station7);
          return Container(
            width: MediaQuery.of(context).size.width - defaultPaddingValue * 4,
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(color: Colors.white, borderRadius: smallBorderRadius),
            child: Padding(
              padding: defaultAllOutsidePadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: stations.map((station) {
                    index++;
                    return Container(
                      height: defaultButtonHeight,
                      width: double.infinity,
                      margin: smallestVerticalPadding,
                      decoration: BoxDecoration(
                          color: index != currentStation ? Colors.white : primaryBlueColor,
                          borderRadius: defaultBorderRadius,
                          border: Border.all(color: primaryBlueColor, width: 2)),
                      child: Center(
                        child: Text(
                          station,

                          /// style: TextStyle(
                          ///   color: index != currentStation ? primaryBlueColor : Colors.white,
                          /// ),
                          style: index == currentStation
                              ? Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.normal, fontSize: titleDefaultFontSize)
                              : Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: importandTextColor,
                                  fontSize: titleDefaultFontSize),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        });
  }
}
