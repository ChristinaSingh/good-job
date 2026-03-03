import 'package:flutter/material.dart';
import 'package:good_job/common/colors.dart';

class MThemeData {
  static ThemeData themeData() {
    return ThemeData(
      fontFamily: 'FontBold',
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: primary3Color, //
      primaryColor: const Color(0xff4C9581),
      secondaryHeaderColor: const Color(0xff4C9581), //Primary2Color
      hintColor: const Color(0xff4C9581),
      focusColor: const Color(0xff4C9581), // TextColor
      hoverColor: const Color(0xff4C9581),
      highlightColor: const Color(0xff4C9581), // primary3Color
      unselectedWidgetColor: const Color(0xff4C9581),
      cardColor: const Color(0xFFFFFFFF),
      cardTheme: const CardTheme(
        surfaceTintColor: Colors.white,
      ), // primary3Color
    );
  }
}
