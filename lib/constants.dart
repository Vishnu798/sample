import 'package:flutter/widgets.dart';

class Constants {
  Constants();

  static const double textPrimary = 16.0;
  static const double textSmallHeading = 20.0;
  static const double textUser = 18.0;
  static const double padding = 8.0;
  static const double paddingExLarge = 128.0;
  static const double cornerRadius = 8.0;
  static const double minRadius = 4.0;
  static const double avatarRadius = 66.0;
  static const double cardMarginVertical = 12.0;
  static const double cardMarginHorizontal = 20.0;

  static const Color colorBackground = Color(0xFFEEEEEE);
  static const Color kLightShadow = Color(0x2F000000);
  static const Color kDarkShadow = Color(0x3F000000);

  static const Color cardBackground = Color(0xFFECEFF1);

  static const kTextStyle = TextStyle(fontSize: 14);

  static const List<BoxShadow> lightShadow = <BoxShadow>[
    BoxShadow(
      color: kLightShadow,
      blurRadius: 8.0,
      offset: Offset(0.0, 8.0),
    ),
  ];

  static const List<BoxShadow> darkShadow = <BoxShadow>[
    BoxShadow(
      color: kDarkShadow,
      blurRadius: 8.0,
      offset: Offset(0.0, 8.0),
    ),
  ];
}