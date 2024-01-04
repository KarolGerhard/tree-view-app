import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeApp {
  static final theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF2188FF),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF2188FF)),
        textStyle: MaterialStateTextStyle.resolveWith((states) => const TextStyle(color: Colors.white)),
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.inter().fontFamily,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.w300, color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xFF17192D),
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 23, 
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF17192D),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
}
