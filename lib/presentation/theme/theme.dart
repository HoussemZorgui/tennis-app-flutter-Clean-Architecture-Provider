import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.indigo,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    background: AppColors.background,
    error: AppColors.error,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.primary,
    titleTextStyle: AppTextStyles.headline6.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    buttonColor: AppColors.primary,
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.headline6,
    titleMedium: AppTextStyles.subtitle1,
    bodyLarge: AppTextStyles.bodyText1,
    bodyMedium: AppTextStyles.bodyText2,
    labelLarge: AppTextStyles.button,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor: Colors.white,
  ),
);
