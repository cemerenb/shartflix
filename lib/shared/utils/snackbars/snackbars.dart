import 'package:flutter/material.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class CustomSnackbar {
  static void errorSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(color: AppTheme.white),
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.errorContainer,
        duration: duration,
      ),
    );
  }

  static void successSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(color: AppTheme.white),
        ),
        backgroundColor: const Color.fromARGB(255, 102, 196, 105),
        duration: duration,
      ),
    );
  }

  static void soonSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyMedium?.copyWith(color: AppTheme.white),
        ),
        backgroundColor: AppTheme.accentColor,
        duration: duration,
      ),
    );
  }
}
