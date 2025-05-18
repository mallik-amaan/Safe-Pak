import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      fontFamily: 'Urbanist',
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
        accentColor: AppColors.secondaryColor,
      ),
      highlightColor: AppColors.primaryColor,
      shadowColor: AppColors.secondaryColor,
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        titleTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
  );
}
