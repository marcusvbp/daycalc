import 'package:daycalc/app/config/app_colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: AppColors.lightColorScheme,
  textTheme: AppColors.lightTextTheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightPrimaryText,
    elevation: 0,
  ),
  cardTheme: const CardThemeData(elevation: 2),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.lightAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.lightSecondaryText.withValues(alpha: 0.3),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.lightSecondaryText.withValues(alpha: 0.3),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.lightAccent, width: 2),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: AppColors.darkColorScheme,
  textTheme: AppColors.darkTextTheme,
  useMaterial3: true,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: AppColors.darkSurface,
  //   foregroundColor: AppColors.darkPrimaryText,
  //   elevation: 0,
  //   centerTitle: true,
  // ),
  cardTheme: const CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.darkSecondaryText.withValues(alpha: 0.3),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.darkSecondaryText.withValues(alpha: 0.3),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.darkAccent, width: 2),
    ),
  ),
);
