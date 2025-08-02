import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';

Future<void> showImagePickerBottomSheet(
  BuildContext context,
  ImagePicker picker,
  Function onSelected,
) async {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.selectPhoto,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPickerOption(
                  context: context,
                  icon: Icons.camera_alt,
                  label: context.l10n.camera,
                  onTap: () => pickImage(
                    context,
                    ImageSource.camera,
                    picker,
                    onSelected,
                  ),
                ),
                buildPickerOption(
                  context: context,
                  icon: Icons.photo_library,
                  label: context.l10n.gallery,
                  onTap: () => pickImage(
                    context,
                    ImageSource.gallery,
                    picker,
                    onSelected,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

Widget buildPickerOption({
  required BuildContext context,
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 8),
        Text(label, style: context.textTheme.bodyMedium),
      ],
    ),
  );
}

Future<void> pickImage(
  BuildContext context,
  ImageSource source,
  ImagePicker picker,
  Function onSelected,
) async {
  try {
    final XFile? image = await picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null && context.mounted) {
      onSelected(File(image.path));
      Navigator.pop(context);
    }
  } catch (e) {
    if (context.mounted) {
      CustomSnackbar.errorSnackbar(
        context: context,
        message: context.l10n.photoUploadError,
      );
    }
  }
}
