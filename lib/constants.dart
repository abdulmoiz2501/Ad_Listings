import 'package:flutter/material.dart';

// class Palette{
//   static const MaterialColor kToDark = const MaterialColor(
//     0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
//     const <int, Color>{
//       500: const Color(0xFF2D5D70),//60%
//     },
//   );
// }

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
// Colors
const kBackgroundColor = Color(0xFFD2FFF4);
const kPrimaryColor = Color(0xFF2D5D70);
const kSecondaryColor = Color(0xFF265DAB);
const kSecondaryColor2 = Color(0x0fffe8d1);
const kTextColor = Color(0xFF222B45);
const kShadowColor = Color(0xFFE6E6E6);
const kActiveIconColor = Color(0xFFE68342);
const kOrange = Color(0xFFF2BEA1);
const kBlueColor = Color(0xFF817DC0);
const kBlueLightColor = Color(0xFFC7B8F5);
const kMainMenuColor = Color(0xFFF5CEB8);
const kContrast = Color(0xFF005B47);
