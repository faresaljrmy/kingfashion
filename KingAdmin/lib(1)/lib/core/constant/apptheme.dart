import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor),
  fontFamily: "PlayfairDisplay",
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 18,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.primaryColor)),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontSize: 14,
    ),
  ),
  // colorScheme: const ColorScheme(background: AppColors.appBgColor),
);

ThemeData themeArabic = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor),
  fontFamily: "sace",
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      elevation: 0,
      titleTextStyle: const TextStyle(
          fontSize: 18,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold),
      iconTheme: const IconThemeData(color: AppColors.primaryColor)),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColors.black),
    bodyLarge: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColors.grey,
      fontSize: 14,
    ),
  ),
);
