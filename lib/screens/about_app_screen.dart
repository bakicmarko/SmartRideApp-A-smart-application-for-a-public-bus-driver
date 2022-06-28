import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:smart_ride_app/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
              largeHeightDivideBox,
              Center(
                child: Text('Final thesis',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400)),
              ),
              largeHeightDivideBox,
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CustomRowLayout(
                      textKey: 'Title:',
                      textValues: ['Smart application for bud drivers in public transport'],
                      numberOfLines: 1,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'Author:',
                      textValues: ['Marko Bakić', 'mb51889@fer.hr'],
                      numberOfLines: 2,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'Menthor:',
                      textValues: [
                        'doc. dr. sc. Jurica Babić',
                        'Department of Telecommunications',
                        'jurica.babic@fer.hr'
                      ],
                      numberOfLines: 3,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'University:',
                      textValues: ['University of Zagreb', 'Faculty of Electrical Engineering and Computing'],
                      numberOfLines: 2,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'Course:',
                      textValues: ['Computing'],
                      numberOfLines: 1,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'Year:',
                      textValues: ['2022/2023'],
                      numberOfLines: 1,
                      isLast: false,
                    ),
                    CustomRowLayout(
                      textKey: 'URL:',
                      textValues: ['https://www.overleaf.com/project/627dfe9db105e753cc61aac2'],
                      numberOfLines: 1,
                      isLast: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: defaultAllOutsidePadding,
          child: ElevatedButton(
            onPressed: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: Text('Please contact author at given email!'),
                  );
                },
              )
            },
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, defaultButtonHeight)),
                ),
            child: const Text("Contact me"),
          ),
        ),
      ),
    );
  }
}

class CustomRowLayout extends StatelessWidget {
  const CustomRowLayout(
      {Key? key, required this.textKey, required this.textValues, required this.numberOfLines, required this.isLast})
      : super(key: key);

  final String textKey;
  final List<String> textValues;
  final int numberOfLines;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyleBold = Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12);
    TextStyle? textStyleNormal = Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12);
    final oneTextLineHeight = MediaQuery.of(context).size.height / 33;
    final smallcontainerWidth = MediaQuery.of(context).size.width / 7;
    final bigcontainerWidth = MediaQuery.of(context).size.width - smallcontainerWidth - defaultPaddingValue * 2;

    /// debugPrint(MediaQuery.of(context).size.width.toString());
    /// debugPrint(bigcontainerWidth.toString());

    return Row(
      children: [
        SizedBox(
          height: oneTextLineHeight * numberOfLines,
          width: smallcontainerWidth,
          child: Text(textKey, style: textStyleNormal),
        ),
        SizedBox(
          height: oneTextLineHeight * numberOfLines,
          width: bigcontainerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textValues
                .map(
                  (val) => !isLast
                      ? Text(val, style: textStyleBold, maxLines: 1, overflow: TextOverflow.ellipsis)
                      : Linkify(
                          text: val,
                          onOpen: (link) async {
                            if (await canLaunchUrl(Uri.parse(link.url))) {
                              await launchUrl(Uri.parse(link.url));
                            } else {
                              debugPrint('Cannot open link: ${link.url}');
                            }
                          },
                        ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
