import 'package:flutter/material.dart';

const Color primaryBlueColor = Color.fromRGBO(107, 139, 219, 1);
const Color primaryGreyColor = Color.fromRGBO(171, 170, 170, 1);

const Color primaryTextColor = primaryGreyColor;
const Color secondaryTextColor = Colors.white;

const Color importandTextColor = primaryBlueColor;
const Color titleTextColor = Colors.black;

const double defaultBodyFontSize = 9;
const double mediumBodyFontSize = 12;
const double largeBodyFontSize = 20;

const double titleSmallFontSize = 10;
const double titleLargeFontSize = 45;

const FontWeight defaultBoldWeight = FontWeight.bold;

const EdgeInsetsGeometry defaultButtonPadding = EdgeInsets.all(15);
const double elevatedButtonElevation = 10;
const double defaultButtonHeight = 45;
const double defaultButtonWidth = 120;

const double defaultButtonBorderRadius = 20;

const double defaultButtonTextFontSize = 15;

const double defaultPaddingValue = 20;
const double mediumPaddingValue = 30;
const EdgeInsetsGeometry mediumAllOutsidePadding = EdgeInsets.all(mediumPaddingValue);

const SizedBox defaultHeightDivideBox = SizedBox(height: 20);
const SizedBox mediumHeightDivideBox = SizedBox(height: 30);

const SizedBox defaultWidthDivideBox = SizedBox(width: 20);
const SizedBox mediumWidthDivideBox = SizedBox(width: 30);

BorderRadius defaultBorderRadius = BorderRadius.circular(30);

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
      fontSize: defaultBodyFontSize,
      fontWeight: defaultBoldWeight,
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
      padding: MaterialStateProperty.all(defaultButtonPadding),
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
