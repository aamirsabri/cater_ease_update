import 'package:flutter/material.dart';

class ColorManager {
  // static Color primary = HexColor.fromHex("#FBB701");
  static Color backgroundDark = HexColor.fromHex("#F5F5F5");
  static Color backgroundLight = HexColor.fromHex("#FFFFFF");
  // static Color primary = HexColor.fromHex("#5292f7");
  static Color primary = HexColor.fromHex("#ce871a");
  
  // static Color primary = HexColor.fromHex("#125421");
  static Color primaryLight = HexColor.fromHex("#4e8ff2");
  static Color darkPrimary = HexColor.fromHex("#7b1fa2");
  static Color darkgrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9e9e9e");
  // static Color primaryOpacity70 = HexColor.fromHex("#B3FB8701");
  static Color primaryOpacity70 = HexColor.fromHex("#E8F4E4");
  static Color primaryFont = HexColor.fromHex("#3A3B3C");
  static Color secondaryFont = HexColor.fromHex("FFFFFF");
  static Color primaryFontOpacity70 = HexColor.fromHex("#999999");

  // static Color secondary = HexColor.fromHex("#0541e1");
  static Color secondary = HexColor.fromHex("#414141");
  // static Color secondary = HexColor.fromHex("#3478E9");

  static Color error = HexColor.fromHex("#E61F34");
  static Color white = HexColor.fromHex("#FFFFFF");

  
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF" + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
