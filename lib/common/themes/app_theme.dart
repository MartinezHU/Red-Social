import 'package:flutter/material.dart';
import 'colors.dart'; // Asegúrate de importar el archivo de colores

ThemeData buildAppTheme() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: AppColors.surfaceColor,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        brightness: Brightness.dark),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.onBackground, // Color del texto principal
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColors.onBackground, // Color del texto principal
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.onBackground, // Color del texto secundario
        fontSize: 14,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.onPrimary),
      titleTextStyle: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
    ),
    cardTheme: const CardTheme(
      color: AppColors.surfaceColor,
      elevation: 4,
    ),
    dividerColor: AppColors.onSurface.withOpacity(0.5),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.onSurface,
    ),
  );
}
