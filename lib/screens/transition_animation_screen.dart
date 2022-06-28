import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wave/config.dart';

import 'dart:async';

import 'package:smart_ride_app/theme/theme.dart';
import 'package:wave/wave.dart';

class TransitionScreen extends StatefulWidget {
  const TransitionScreen({Key? key, required this.nextScreen}) : super(key: key);

  final Widget nextScreen;

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _logoAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(0, 0.15),
  ).animate(
    _animationController,
  );

  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => widget.nextScreen),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static const _colors = [
    lightBlueColor,
    primaryBlueColor,
  ];

  static const _durations = [
    6000,
    5000,
  ];

  static const _heightPercentages = [
    0.1,
    0.05,
  ];

  @override
  Widget build(BuildContext context) {
    final double backgroundContainersHeight = MediaQuery.of(context).size.height / 1.8;
    const double waveHeight = 200;
    double waveWidth = MediaQuery.of(context).size.width;
    double busTopOffset = backgroundContainersHeight - 210;
    double busWidth = MediaQuery.of(context).size.width / 1.4;
    double busLeftOffset = (MediaQuery.of(context).size.width / 2) - (busWidth / 2);
    return Scaffold(
        backgroundColor: lightBlueColor,
        body: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: lightestBlueColor,
                  width: double.infinity,
                  height: backgroundContainersHeight,
                ),
              ),
            ),
            Positioned(
              top: backgroundContainersHeight - waveHeight,
              child: WaveWidget(
                isLoop: true,
                config: CustomConfig(
                  colors: _colors,
                  durations: _durations,
                  heightPercentages: _heightPercentages,
                ),
                size: Size(waveWidth, waveHeight),
                waveAmplitude: 20,
              ),
            ),
            Positioned(
              top: busTopOffset,
              left: busLeftOffset,
              child: SlideTransition(
                position: _logoAnimation,
                child: SvgPicture.asset('assets/vectors/bus.svg', width: busWidth),

                /// child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ],
        ));
  }
}
