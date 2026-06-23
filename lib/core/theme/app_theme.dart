

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    //appbar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      centerTitle: false,

      iconTheme: IconThemeData(color: AppColors.textPrimaryColor),

      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      ///for title of news
      titleLarge: TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      ///use it for details of news
      bodyLarge: TextStyle(
        color: AppColors.textPrimaryColor,
        fontSize: 16,
      ),
      ///to describe news
      bodyMedium: TextStyle(
        color: AppColors.textSecondaryColor,
        fontSize: 14,
      ),
      ///for date of news
      labelSmall: TextStyle(
        color: AppColors.textSecondaryColor,
        fontSize: 12,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      background: AppColors.backgroundColor,
      surface: AppColors.surfaceColor
    ),
  );
}