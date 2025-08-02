import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

Widget buildSwitchTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: SwitchListTile(
      secondary: Icon(icon),
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle, style: context.textTheme.bodySmall),
      value: value,
      onChanged: onChanged,
    ),
  );
}
