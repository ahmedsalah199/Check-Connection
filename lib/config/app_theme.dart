import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.black,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.red,
            systemNavigationBarIconBrightness: Brightness.light)),
  );
}
