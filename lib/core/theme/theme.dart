import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/palette.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Palette.scaffoldBackgroundColor,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Palette.primaryBlue,
        onPrimary: Colors.white,
        secondary: Palette.defaultTextColor,
        onSecondary: Palette.defaultTextColor,
        error: Palette.red,
        onError: Palette.red,
        surface: Palette.bodyBG,
        onSurface: Palette.videoCardColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 12, color: Palette.defaultTextColor),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Palette.primaryBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
      ),
      primaryColor: Palette.primaryBlue,
      bottomAppBarTheme: const BottomAppBarTheme(color: Palette.buttonGrey),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Palette.defaultTextColor.withValues(alpha: 0.5);
            }
            return Palette.primaryBlue;
          }),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.all(20.0)),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Palette.grey;
            }
            return Palette.primaryBlue;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Palette.defaultTextColor.withValues(alpha: 0.5);
            }
            return Colors.white;
          }),
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Palette.primaryBlue,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: Palette.bodyBG,
        iconTheme: IconThemeData(color: Palette.primaryBlue),
      ),
      //textTheme: GoogleFonts.interTextTheme(),
      textTheme: ThemeData.light().textTheme.copyWith(
            headlineSmall: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            titleLarge: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            titleMedium: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            titleSmall: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            bodyLarge: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            bodyMedium: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            bodySmall: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            labelMedium: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
            labelSmall: GoogleFonts.inter(
              letterSpacing: 0.0,
              fontStyle: FontStyle.normal,
            ),
          ),
      unselectedWidgetColor: Colors.blue[400],
      iconTheme: const IconThemeData(color: Palette.defaultTextColor),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        textStyle: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Palette.primaryBlue,
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
