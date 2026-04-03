import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,

    // Define cores base do app
    colorScheme: const ColorScheme.light(
      surface: AppColors.background,

      primary: AppColors.primary,
      secondary: AppColors.secondary,

      onPrimary: Colors.white,
      onSecondary: Colors.white,

      onSurface: AppColors.foreground,

      error: AppColors.softRed,
      onError: AppColors.onSoftRed,
    ),

    // Fundo padrão do Scaffold
    scaffoldBackgroundColor: AppColors.background,

    // Texto padrão
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.foreground),
      bodyMedium: TextStyle(color: AppColors.foreground),
      bodySmall: TextStyle(color: AppColors.foreground),

      titleLarge: TextStyle(color: AppColors.foreground),
      titleMedium: TextStyle(color: AppColors.foreground),
      titleSmall: TextStyle(color: AppColors.foreground),

      labelLarge: TextStyle(color: AppColors.foreground),
    ),

    // Aplica cor padrão global em textos herdados
    primaryTextTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.foreground),
    ),

    // AppBar 
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.foreground,
      elevation: 0,
    ),
  );
}