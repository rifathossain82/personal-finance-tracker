import 'package:personal_finance_tracker/src/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primarySwatch: kPrimarySwatchColor,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhite,
      elevation: 1.0,
      centerTitle: true,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.notoSerifBengali(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: kWhite,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        /// Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: kWhite,
    ),
    textTheme: GoogleFonts.notoSerifBengaliTextTheme(Typography.blackCupertino),
    iconTheme: const IconThemeData(
      color: kGrey,
    ),
  );

  /// Enable Android 15 compatible edge-to-edge mode
  static void enableEdgeToEdge() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    /// Transparent overlays → Let Flutter draw under them
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }


  /// to hide top and bottom, both status bar
  static void hideStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}