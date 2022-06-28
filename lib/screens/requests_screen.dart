import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/models/request.dart';
import 'package:smart_ride_app/providers/listeners/provider_listener.dart';
import 'package:smart_ride_app/providers/requests_provider.dart';
import 'package:smart_ride_app/theme/theme.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RequestsProvider(context.read(), user, context.read()),
      child: const _RequestsScreenView(),
    );
  }
}

class _RequestsScreenView extends StatelessWidget {
  const _RequestsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RequestsProvider>(
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
            )
          }),
      child: const _RequestsScreenContent(),
    );
  }
}

class _RequestsScreenContent extends StatelessWidget {
  const _RequestsScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RequestsProvider>();
    List<Request> requests = [];
    provider.state.maybeWhen(
      orElse: () => {},
      success: (list) {
        requests = list;
        debugPrint('success');
      },
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: defaultAllOutsidePadding,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: primaryBlueColor,
                    ),
                  ),
                ),
                Column(
                  children: requests.map((request) => CustomCardRequest(request: request)).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCardRequest extends StatelessWidget {
  const CustomCardRequest({Key? key, required this.request}) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    const double containerHeight = 250;
    const double smallIconSize = 20;
    return Container(
      width: double.infinity,
      height: containerHeight,
      margin: smallAllOutsidePadding,
      child: Material(
        elevation: elevatedButtonElevation,
        borderRadius: defaultBorderRadius,
        color: primaryBlueColor,
        child: Column(
          children: [
            Container(
              height: 100,
              padding: smallAllOutsidePadding,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
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
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${request.firstName} ${request.surName}',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          request.email,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          request.phoneNumber,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Icon(
                        request.accepted == 0 ? Icons.close : Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: double.infinity, height: 1, color: Colors.white),
            Expanded(
              flex: 5,
              child: Padding(
                  padding: smallAllOutsidePadding,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.hail, color: Colors.white, size: smallIconSize),
                          Expanded(
                            child: Container(
                              width: 4,
                              margin: smallestVerticalPadding,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: smallBorderRadius),
                            ),
                          ),
                          const Icon(Icons.pin_drop_outlined, color: Colors.white, size: smallIconSize),
                        ],
                      ),
                      smallWidthDivideBox,
                      Expanded(
                        child: Padding(
                          padding: smallest2VerticalPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Starting location: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: displaySmallFontSize),
                                  ),
                                  Expanded(
                                    child: Text(
                                      request.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontSize: displaySmallFontSize),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Destination: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: displaySmallFontSize),
                                  ),
                                  Expanded(
                                    child: Text(
                                      request.destination,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(fontSize: displaySmallFontSize),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      smallWidthDivideBox,
                      Container(
                        height: double.infinity,
                        width: 1,
                        color: Colors.white,
                      ),
                      smallWidthDivideBox,
                      smallWidthDivideBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${request.travelTime} min',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          smallHeightDivideBox,
                          Text(
                            '${request.travelDistance} km',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 2,
              child: request.accepted != 0
                  ? Padding(
                      padding: defaultHorizontalPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RatingBar(
                            initialRating: request.rating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Colors.white),
                              half: const Icon(Icons.star, color: Colors.white),
                              empty: const Icon(Icons.star_outline, color: Colors.white),
                            ),
                            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                            itemSize: 15,
                            onRatingUpdate: (rating) {},
                          ),
                          smallWidthDivideBox,
                          SizedBox(
                            height: 15,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(request.rating.toString(), style: Theme.of(context).textTheme.displaySmall),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
