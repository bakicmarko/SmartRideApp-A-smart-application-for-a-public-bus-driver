import 'package:flutter/material.dart';
import 'package:smart_ride_app/theme/theme.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
              largeHeightDivideBox,
              Center(
                  child: Text('Final thesis',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400)))
            ],
          ),
        ),
      ),
    );
  }
}
