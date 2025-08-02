import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);
    final bottomNavHeight = context.screenHeight * 0.15;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Sayfa içeriği, alt taraftan biraz padding ile yukarı çekildi
          child,

          // Yüzen bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: bottomNavHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                // istersen gölge ekleyebilirsin:
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Spacers.horizontalExtraLarge,
                    _buildNavItem(
                      context,
                      index: 0,
                      icon: "assets/icon/home.png",
                      label: context.l10n.home,
                      isSelected: currentIndex == 0,
                    ),
                    Spacers.horizontalExtraLarge,
                    _buildNavItem(
                      context,
                      index: 1,
                      icon: "assets/icon/person_home.png",
                      label: context.l10n.profile,
                      isSelected: currentIndex == 1,
                    ),
                    Spacers.horizontalExtraLarge,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String icon,
    required String label,
    required bool isSelected,
  }) {
    final brightness = Theme.of(context).brightness;

    Color backgroundColor;
    Color textColor;

    if (isSelected) {
      if (brightness == Brightness.light) {
        backgroundColor = AppTheme.accentColor;
        textColor = AppTheme.white;
      } else {
        backgroundColor = AppTheme.white;
        textColor = AppTheme.black;
      }
    } else {
      if (brightness == Brightness.light) {
        backgroundColor = AppTheme.white;
        textColor = AppTheme.black;
      } else {
        backgroundColor = AppTheme.black;
        textColor = AppTheme.white;
      }
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(context, index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 1, color: textColor),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, color: textColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case '/home':
        return 0;
      case '/profile':
        return 1;
      default:
        return 0;
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/profile');
        break;
    }
  }
}
