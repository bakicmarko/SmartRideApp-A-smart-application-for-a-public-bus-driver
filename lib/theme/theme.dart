import 'package:flutter/material.dart';

const Color primaryBlueColor = Color.fromRGBO(107, 139, 219, 1);
const Color primaryGreyColor = Color.fromRGBO(171, 170, 170, 1);

const Color primaryTextColor = primaryGreyColor;
const Color secondaryTextColor = Colors.white;

const Color importandTextColor = primaryBlueColor;
const Color titleTextColor = Colors.black;

const Color redColor = Color.fromRGBO(234, 67, 53, 1);
const Color greenColor = Color.fromRGBO(118, 205, 145, 1);

const double defaultBodyFontSize = 9;
const double mediumBodyFontSize = 12;
const double largeBodyFontSize = 40;

const double titleSmallFontSize = 10;
const double titleDefaultFontSize = 15;
const double titleLargeFontSize = 45;

const double displayMediumFontSize = 17;

const FontWeight defaultBoldWeight = FontWeight.w500;
const FontWeight mediumBoldWeight = FontWeight.w600;

const EdgeInsetsGeometry defaultButtonPadding = EdgeInsets.all(15);
const double elevatedButtonElevation = 10;

const double smallButtonHeight = 35;
const double defaultButtonHeight = 45;

const double smallButtonWidth = 90;
const double defaultButtonWidth = 120;

const double smallButtonBorderRadius = 10;
const double defaultButtonBorderRadius = 20;

const double defaultButtonTextFontSize = 15;

const double smallPaddingValue = 10;
const double defaultPaddingValue = 20;
const double mediumPaddingValue = 30;
const EdgeInsetsGeometry smallAllOutsidePadding = EdgeInsets.all(smallPaddingValue);
const EdgeInsetsGeometry defaultAllOutsidePadding = EdgeInsets.all(defaultPaddingValue);
const EdgeInsetsGeometry mediumAllOutsidePadding = EdgeInsets.all(mediumPaddingValue);
const EdgeInsetsGeometry defaultHorizontalPadding = EdgeInsets.symmetric(horizontal: defaultPaddingValue);
const EdgeInsetsGeometry smallHorizontalPadding = EdgeInsets.symmetric(horizontal: smallPaddingValue);
const EdgeInsetsGeometry defaultVerticalPadding = EdgeInsets.symmetric(vertical: defaultPaddingValue);

const SizedBox smallestHeightDivideBox = SizedBox(height: 5);
const SizedBox small2HeightDivideBox = SizedBox(height: 10);
const SizedBox smallHeightDivideBox = SizedBox(height: 14);
const SizedBox defaultHeightDivideBox = SizedBox(height: 20);
const SizedBox mediumHeightDivideBox = SizedBox(height: 30);
const SizedBox largeHeightDivideBox = SizedBox(height: 40);

const SizedBox smallWidthDivideBox = SizedBox(width: 5);
const SizedBox defaultWidthDivideBox = SizedBox(width: 20);
const SizedBox mediumWidthDivideBox = SizedBox(width: 30);
const SizedBox largeWidthDivideBox = SizedBox(width: 45);

BorderRadius smallBorderRadius = BorderRadius.circular(15);
BorderRadius defaultBorderRadius = BorderRadius.circular(30);

Divider divider = Divider(thickness: 2, color: primaryGreyColor.withOpacity(.5));

double iconSizeValue = 70;
Size iconSize = Size(iconSizeValue, iconSizeValue);

final ThemeData theme = ThemeData(
  primaryColor: primaryBlueColor,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: primaryTextColor,
      fontSize: defaultBodyFontSize,
    ),
    bodyMedium: TextStyle(
      color: primaryTextColor,
      fontSize: mediumBodyFontSize,
    ),
    bodyLarge: TextStyle(
      color: titleTextColor,
      fontWeight: defaultBoldWeight,
      fontSize: largeBodyFontSize,
    ),
    titleSmall: TextStyle(
      color: titleTextColor,
      fontSize: titleSmallFontSize,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: titleTextColor,
      fontSize: titleDefaultFontSize,
      fontWeight: mediumBoldWeight,
    ),
    titleLarge: TextStyle(
      color: titleTextColor,
      fontSize: titleLargeFontSize,
    ),
    displaySmall: TextStyle(
      color: secondaryTextColor,
      fontSize: defaultBodyFontSize,
    ),
    displayMedium: TextStyle(
      color: secondaryTextColor,
      fontSize: displayMediumFontSize,
      fontWeight: mediumBoldWeight,
    ),
    displayLarge: TextStyle(
      color: secondaryTextColor,
      fontSize: largeBodyFontSize,
      fontWeight: defaultBoldWeight,
    ),
  ),
  textButtonTheme: null,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryBlueColor),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      elevation: MaterialStateProperty.all(elevatedButtonElevation),
      shadowColor: MaterialStateProperty.all(primaryGreyColor),
      minimumSize: MaterialStateProperty.all(const Size(defaultButtonWidth, defaultButtonHeight)),
      maximumSize: MaterialStateProperty.all(const Size(double.infinity, defaultButtonHeight)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultButtonBorderRadius)),
      ),
      textStyle:
          MaterialStateProperty.all(const TextStyle(color: secondaryTextColor, fontSize: defaultButtonTextFontSize)),

      /// primary: primaryBlueColor,
      /// padding: defaultButtonPadding,
      /// elevation: elevatedButtonElevation,
      /// shadowColor: primaryGreyColor,
    ),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: primaryGreyColor),
    prefixIconColor: primaryGreyColor,
  ),
);
