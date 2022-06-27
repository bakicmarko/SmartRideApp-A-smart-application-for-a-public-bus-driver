import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/models/User.dart';
import 'package:smart_ride_app/providers/home_screen_provider.dart';
import 'package:smart_ride_app/screens/drivers_screen.dart';
import 'package:smart_ride_app/screens/login_screen.dart';

import '../theme/theme.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.openDetailsSheet}) : super(key: key);

  final VoidCallback openDetailsSheet;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(defaultButtonBorderRadius),
          bottomRight: Radius.circular(defaultButtonBorderRadius),
        ),
      ),
      child: Padding(
        padding: defaultAllOutsidePadding,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,

                /// color: Colors.yellow,
                child: const NavBarHeader(),
              ),
            ),
            Expanded(
              flex: 4,
              child: NavBarRouteButtons(openDetailsSheet: openDetailsSheet),
            ),
            Expanded(
              flex: 3,
              child: NavBarBottom(
                logOutUser: provider.logOutUser,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavBarHeader extends StatelessWidget {
  const NavBarHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    User? user = provider.getUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => {},
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                shape: MaterialStateProperty.all(const CircleBorder(side: BorderSide(color: primaryBlueColor))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(iconSize),
                maximumSize: MaterialStateProperty.all(iconSize),
              ),
          child: const Icon(Icons.person, color: primaryGreyColor, size: 45),
        ),
        defaultHeightDivideBox,
        Row(children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2.8,
            ),
            child: Text(
              '${user?.firstName} ${user?.surName}',
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          smallWidthDivideBox,
          smallWidthDivideBox,
          Text('${user?.rating.toString()}', style: Theme.of(context).textTheme.titleSmall),
          const Icon(Icons.star, color: Colors.black, size: titleDefaultFontSize),
        ]),
        small2HeightDivideBox,
        Text('${user?.email}', style: Theme.of(context).textTheme.titleSmall),
        smallestHeightDivideBox,
        Text('${user?.phoneNumber}', style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}

class NavBarRouteButtons extends StatefulWidget {
  const NavBarRouteButtons({Key? key, required this.openDetailsSheet}) : super(key: key);

  final VoidCallback openDetailsSheet;

  @override
  State<NavBarRouteButtons> createState() => _NavBarRouteButtonsState();
}

class _NavBarRouteButtonsState extends State<NavBarRouteButtons> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 0;
            });
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallButtonBorderRadius)),
              ),
              backgroundColor:
                  index == 0 ? MaterialStateProperty.all(primaryBlueColor) : MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(const BorderSide(color: primaryGreyColor)),
              elevation: MaterialStateProperty.all(0)),
          child: Padding(
            padding: smallHorizontalPadding,
            child: Row(
              children: [
                Icon(Icons.home, color: index == 0 ? Colors.white : primaryGreyColor),
                mediumWidthDivideBox,
                Text(
                  "Home",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: index == 0 ? Theme.of(context).textTheme.displayMedium!.color : primaryGreyColor),
                ),
              ],
            ),
          ),
        ),
        small2HeightDivideBox,
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 1;
            });
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallButtonBorderRadius)),
              ),
              backgroundColor:
                  index == 1 ? MaterialStateProperty.all(primaryBlueColor) : MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(const BorderSide(color: primaryGreyColor)),
              elevation: MaterialStateProperty.all(0)),
          child: Padding(
            padding: smallHorizontalPadding,
            child: Row(
              children: [
                Icon(Icons.pending_actions, color: index == 1 ? Colors.white : primaryGreyColor),
                mediumWidthDivideBox,
                Text(
                  "Requests",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: index == 1 ? Theme.of(context).textTheme.displayMedium!.color : primaryGreyColor),
                ),
              ],
            ),
          ),
        ),
        small2HeightDivideBox,
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 2;
            });
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const DriversScreen()));
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallButtonBorderRadius)),
              ),
              backgroundColor:
                  index == 2 ? MaterialStateProperty.all(primaryBlueColor) : MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(const BorderSide(color: primaryGreyColor)),
              elevation: MaterialStateProperty.all(0)),
          child: Padding(
            padding: smallHorizontalPadding,
            child: Row(
              children: [
                Icon(Icons.directions_bus_outlined, color: index == 2 ? Colors.white : primaryGreyColor),
                mediumWidthDivideBox,
                Text(
                  "Drivers",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: index == 2 ? Theme.of(context).textTheme.displayMedium!.color : primaryGreyColor),
                ),
              ],
            ),
          ),
        ),
        small2HeightDivideBox,
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = 3;
            });
            widget.openDetailsSheet;
            Navigator.pop(context);
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallButtonBorderRadius)),
              ),
              backgroundColor:
                  index == 3 ? MaterialStateProperty.all(primaryBlueColor) : MaterialStateProperty.all(Colors.white),
              side: MaterialStateProperty.all(const BorderSide(color: primaryGreyColor)),
              elevation: MaterialStateProperty.all(0)),
          child: Padding(
            padding: smallHorizontalPadding,
            child: Row(
              children: [
                Icon(Icons.info_outline, color: index == 3 ? Colors.white : primaryGreyColor),
                mediumWidthDivideBox,
                Text(
                  "Details",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: index == 3 ? Theme.of(context).textTheme.displayMedium!.color : primaryGreyColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NavBarBottom extends StatelessWidget {
  const NavBarBottom({Key? key, required this.logOutUser}) : super(key: key);

  final Future<void> Function() logOutUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () async => {
                      await logOutUser(),
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute<void>(builder: (BuildContext context) => LogInScreen()), (route) => false),
                    },
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: mediumBoldWeight),
                )),
            IconButton(
              splashRadius: 20,
              onPressed: () => {},
              icon: const Icon(
                Icons.info_outline,
                color: primaryGreyColor,
                size: 20,
              ),
            ),
          ],
        ),
        Container(
          height: 38,
          width: 38,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(shape: BoxShape.circle, color: greenColor),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => {},
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
