import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

Positioned buildBottomGradient(BuildContext context) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      height: context.screenHeight * 0.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(190, 0, 0, 0),

            Color.fromARGB(0, 0, 0, 0),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        ),
      ),
    ),
  );
}
