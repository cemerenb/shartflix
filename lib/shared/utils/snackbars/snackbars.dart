import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class CustomSnackbar {
  static void errorSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: context.textTheme.bodyMedium),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.errorContainer,
        duration: duration,
      ),
    );
  }
}
