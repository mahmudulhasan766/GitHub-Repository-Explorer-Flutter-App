import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readback/core/constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    secondaryHeaderColor: const Color(0xFF0044CC),
    cardColor: Colors.white,
    hintColor: Colors.grey.shade600,
    disabledColor: Colors.grey.shade400,
    fontFamily: 'Inter',
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF0044CC), // Fixed: Changed from white to blue
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  /// Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // Changed from pure black
    primaryColor: const Color(0xFF4C8DFF),
    secondaryHeaderColor: const Color(0xFF3366CC),
    cardColor: const Color(0xFF1E1E1E), // Slightly lighter than scaffold
    hintColor: Colors.grey.shade400,
    disabledColor: Colors.grey.shade600,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212), // Changed from pure black
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF121212), // Changed from pure black
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF121212), // Changed from pure black
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF4C8DFF),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4C8DFF),
      secondary: Color(0xFF3366CC),
      surface: Color(0xFF121212),
      onSurface: Colors.white, // Fixed: Changed from black to white
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static Brightness get currentSystemBrightness =>
      PlatformDispatcher.instance.platformBrightness;

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
      themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
      themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor:
      themeMode == ThemeMode.light ? Colors.white : const Color(0xFF121212), // Fixed: Consistent with theme
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}

/// Extra Theme Utilities
extension ThemeExtras on ThemeData {
  Color get particlesColor => brightness == Brightness.light
      ? const Color(0x11000000)
      : const Color(0x22FFFFFF);
}