import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/widgets/custom_container.dart';
import 'package:shartflix/shared/icon_color.dart'; // themedIcon burada olmalı

class SocialLogin extends StatelessWidget {
  final String imagePath;
  const SocialLogin({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(20),
      child: themedIcon(context, imagePath, size: context.screenWidth * 0.06),
    );
  }
}
