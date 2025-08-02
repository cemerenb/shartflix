import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildFavoritePopup(
  BuildContext context,
  bool showFavoritePopup,
  AnimationController favoriteAnimationController,
) {
  if (!showFavoritePopup) return const SizedBox.shrink();

  final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: favoriteAnimationController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInBack,
    ),
  );

  return AnimatedBuilder(
    animation: favoriteAnimationController,
    builder: (context, child) {
      return Center(
        child: Transform.scale(
          scale: scaleAnimation.value,
          child: Lottie.asset(
            'assets/lottie/hearth.json',
            controller: favoriteAnimationController,
            onLoaded: (composition) {
              favoriteAnimationController.duration = composition.duration;
            },
          ),
        ),
      );
    },
  );
}
