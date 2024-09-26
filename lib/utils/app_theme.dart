import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      centerTitle: true,
    ),
    useMaterial3: true,
  );
}
