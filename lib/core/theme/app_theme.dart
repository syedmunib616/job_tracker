// core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:job_tracker/core/constants/app_colors.dart' ;

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceVariant: AppColors.surfaceVariant,
    onBackground: AppColors.textPrimary,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
  ),
  scaffoldBackgroundColor: AppColors.background,
  // cardTheme: CardTheme(
  //   color: AppColors.surface,
  //   elevation: 4,
  //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  // ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textSecondary),
    // ...
  ),
  // etc.
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,              // can keep same or adjust
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer.withOpacity(0.7),
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    onBackground: AppColors.darkTextPrimary,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  // cardTheme: CardTheme(
  //   color: AppColors.darkSurface,
  //   elevation: 2,
  //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  // ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
    bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
    // ...
  ),
);