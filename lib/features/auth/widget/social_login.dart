import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/widgets/custom_container.dart';

class SocialLogin extends StatelessWidget {
  final String imagePath;
  const SocialLogin({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.all(20),
      child: Image.asset(
        imagePath,
        height: context.screenWidth * 0.06,
        width: context.screenWidth * 0.06,
      ),
    );
  }
}
