import 'package:flutter/material.dart';
import 'package:creatorstudio/config/palette.dart';

class CustomTheme {
  ThemeData lightTheme() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonColor: Palette.black,
      accentColor: Palette.lightBlue,
      primaryColor: Palette.black,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(ContinuousRectangleBorder(
            side: BorderSide(color: Palette.black, width: 6),
            borderRadius: BorderRadius.circular(2),
          )),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 30),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return Palette.black;
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(ContinuousRectangleBorder(
            side: BorderSide(color: Palette.lightBlue, width: 2),
            borderRadius: BorderRadius.circular(8),
          )),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
            return TextStyle(fontSize: 18);
          }),
          padding: MaterialStateProperty.resolveWith<EdgeInsets>((states) {
            return EdgeInsets.symmetric(horizontal: 30, vertical: 10);
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return Palette.black;
          }),
        ),
      ),
    );
  }
}
