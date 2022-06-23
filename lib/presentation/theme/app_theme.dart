import 'package:career_path/presentation/theme/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
            colorScheme: darkColorScheme,
            fontFamily: GoogleFonts.firaSans().fontFamily)
        .copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ));
  }

  static ThemeData get lightTheme {
    return ThemeData(
            colorScheme: lightColorScheme,
            fontFamily: GoogleFonts.notoSans().fontFamily)
        .copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ));
  }
}
