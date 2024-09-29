import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.white,
        fontSize: 18,
      ),
      foregroundColor: AppColors.white,
      // iconTheme: IconThemeData(color: AppColors.white),
    ),
    useMaterial3: true,
  );
}
