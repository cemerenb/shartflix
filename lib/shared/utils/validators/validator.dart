import 'package:flutter/cupertino.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class Validators {
  static String? email(
    BuildContext context,
    String? value, {
    String? requiredMsg,
    String? invalidMsg,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMsg ?? context.l10n.emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return invalidMsg ?? context.l10n.invalidEmail;
    }
    return null;
  }

  static String? fullName(
    String? value,
    BuildContext context, {
    String? requiredMsg,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMsg ?? context.l10n.pleaseEnterFullName;
    }

    final words = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();

    if (words.length < 2) {
      return context.l10n.pleaseEnterFullName;
    }

    return null;
  }

  static String? password(
    String? value,
    BuildContext context, {
    String? requiredMsg,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMsg ?? context.l10n.passwordRequired;
    }
    return null;
  }
}
