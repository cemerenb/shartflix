import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/sheet/view_model/sheet_bloc.dart';
import 'package:shartflix/features/sheet/view_model/sheet_event.dart';
import 'package:shartflix/features/sheet/widget/bonus_area.dart';
import 'package:shartflix/features/sheet/widget/jeton_pack_card.dart';
import 'dart:ui';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';

class JetonPackageBottomSheet extends StatelessWidget {
  const JetonPackageBottomSheet({super.key});

  void _closeSheet(BuildContext context) {
    context.read<SheetBloc>().add(HideSheetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _closeSheet(context),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: context.screenHeight * 0.8,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surface.withOpacity(0.95),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: context.screenWidth * 0.01,
                  child: backgrounGradient(context),
                ),
                Positioned(
                  bottom: -20,
                  left: context.screenWidth * 0.01,
                  child: backgrounGradient(context),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _closeSheet(context),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        context.l10n.limitedOffer,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.sheetSubTitle,
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      Spacers.verticalSmall,
                      const BonusArea(),
                      Spacers.verticalSmall,
                      Text(
                        context.l10n.chooseToken,
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          JetonPackageCard(
                            originalAmount: '200',
                            bonusAmount: '330',
                            price: '99,99',
                            discountPercentage: '+10%',
                          ),
                          JetonPackageCard(
                            originalAmount: '2.000',
                            bonusAmount: '3.375',
                            price: '799,99',
                            gradientColor: Color.fromARGB(255, 89, 73, 230),
                            discountPercentage: '+70%',
                            isHighlighted: true,
                          ),
                          JetonPackageCard(
                            originalAmount: '1.000',
                            bonusAmount: '1.350',
                            price: '399,99',
                            discountPercentage: '+35%',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            CustomSnackbar.soonSnackbar(
                              context: context,
                              message: context.l10n.buySoon,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53E3E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            context.l10n.seeAllToken,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container backgrounGradient(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenWidth - context.screenWidth * 0.5,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            AppTheme.accentColor.withAlpha(170),
            context.theme.colorScheme.primary.withAlpha(25),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
