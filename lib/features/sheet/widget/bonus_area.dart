import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shartflix/features/sheet/widget/colorful_container.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class BonusArea extends StatelessWidget {
  const BonusArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.66 / 2.8,
      width: context.screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withAlpha(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Alacağınız Bonuslar',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BonusItem(
                      iconAsset: 'assets/icon/offer_gem.png',
                      title: context.l10n.premiumAccount,
                    ),
                    BonusItem(
                      iconAsset: 'assets/icon/offer_db_heart.png',
                      title: context.l10n.moreMatch,
                    ),
                    BonusItem(
                      iconAsset: 'assets/icon/offer_up.png',
                      title: context.l10n.boost,
                    ),
                    BonusItem(
                      iconAsset: 'assets/icon/offer_heart.png',
                      title: context.l10n.moreLike,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BonusItem extends StatelessWidget {
  final String iconAsset;
  final String title;

  const BonusItem({super.key, required this.iconAsset, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetColorfulContainer(
          child: Image.asset(
            iconAsset,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 8),
        Text(
          title,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
