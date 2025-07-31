import 'package:flutter/material.dart';
import 'package:shartflix/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  // Localization
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  // Theme shortcuts (bonus)
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  // MediaQuery shortcuts (bonus)
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;

  // Navigation shortcuts (bonus)
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);
}
