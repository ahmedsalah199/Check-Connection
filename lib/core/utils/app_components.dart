import 'package:flutter/material.dart';
import 'package:internet_connection/core/utils/app_values.dart';

Icon iconApp(
    {required IconData icon,
    Color color = Colors.white,
    double iconSize = AppSize.s45}) {
  return Icon(
    icon,
    color: color,
    size: iconSize,
  );
}
