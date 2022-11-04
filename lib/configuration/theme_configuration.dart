import 'package:flutter/material.dart';

class ThemeConfiguration {
  // In case we want to choose between multiple fonts
  // in our assets
  static const String fontFamily = 'Roboto';
  static const Color defaultTextColor = Colors.black;
  static const Color primaryColor = Color.fromRGBO(38, 154, 143, 1);
  static const Color secondaryColor = Colors.white;

  static ThemeData applyCustomization(ThemeData original) {
    return original.copyWith(
      textTheme: original.textTheme.apply(
        fontFamily: fontFamily,
        displayColor: defaultTextColor,
        bodyColor: defaultTextColor,
      ),
      appBarTheme: original.appBarTheme.copyWith(
        foregroundColor: primaryColor,
        color: secondaryColor,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(primaryColor),
        ),
      ),
      bottomSheetTheme: original.bottomSheetTheme.copyWith(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
      ),
      dataTableTheme: original.dataTableTheme.copyWith(
        headingTextStyle: const TextStyle(color: secondaryColor),
        headingRowColor: const MaterialStatePropertyAll(primaryColor),
        dataRowColor: const MaterialStatePropertyAll(
          Color.fromRGBO(243, 243, 243, 1),
        ),
      ),
    );
  }
}
