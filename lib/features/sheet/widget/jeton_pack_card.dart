import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shartflix/features/sheet/widget/colorful_container.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class JetonPackageCard extends StatelessWidget {
  final String originalAmount;
  final String bonusAmount;
  final String price;
  final String? discountPercentage;
  final bool isHighlighted;
  final Color? gradientColor;

  const JetonPackageCard({
    super.key,
    required this.originalAmount,
    required this.bonusAmount,
    required this.price,
    this.discountPercentage,
    this.gradientColor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = (context.screenWidth - 60) / 3;

    return SizedBox(
      width: cardWidth,
      height: context.screenHeight * 0.25,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  gradientColor ?? Color.fromARGB(255, 111, 6, 11),
                  AppTheme.accentColor,
                ],
                stops: [0.02, 1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    originalAmount,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bonusAmount,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.l10n.jeton,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    price,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.l10n.weekly,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (discountPercentage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: SheetColorfulContainer(
                  height: 45,
                  width: 45,
                  gradientColor: gradientColor,
                  child: Text(discountPercentage ?? ""),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
