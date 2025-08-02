import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

Widget buildSectionTitle(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, bottom: 8),
    child: Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
