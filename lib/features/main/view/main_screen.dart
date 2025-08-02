import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/sheet/view_model/sheet_bloc.dart';
import 'package:shartflix/features/sheet/view_model/sheet_event.dart';
import 'package:shartflix/features/sheet/view_model/sheet_state.dart';
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
          child,

          BlocBuilder<SheetBloc, SheetState>(
            builder: (context, state) {
              if (state is SheetVisible) {
                return Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: state.sheet,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          BlocBuilder<SheetBloc, SheetState>(
            builder: (context, state) {
              if (state is SheetVisible) return const SizedBox.shrink();

              return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: bottomNavHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
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
              );
            },
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
      backgroundColor = brightness == Brightness.light
          ? AppTheme.accentColor
          : AppTheme.white;
      textColor = brightness == Brightness.light
          ? AppTheme.white
          : AppTheme.black;
    } else {
      backgroundColor = brightness == Brightness.light
          ? AppTheme.white
          : AppTheme.black;
      textColor = brightness == Brightness.light
          ? AppTheme.black
          : AppTheme.white;
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
