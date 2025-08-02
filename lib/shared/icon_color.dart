import 'package:flutter/material.dart';

Image themedIcon(BuildContext context, String assetPath, {double size = 24.0}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final iconColor = isDark ? Colors.white : Colors.black;

  return Image.asset(assetPath, width: size, height: size, color: iconColor);
}
