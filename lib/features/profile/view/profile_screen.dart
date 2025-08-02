import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/features/main/view/main_screen.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_event.dart';
import 'package:shartflix/features/profile/widget/favorities.dart';
import 'package:shartflix/features/profile/widget/logout_dialog.dart';
import 'package:shartflix/features/sheet/view/offer_sheet.dart';
import 'package:shartflix/features/profile/widget/profile_Area.dart';
import 'package:shartflix/features/sheet/view_model/sheet_bloc.dart';
import 'package:shartflix/features/sheet/view_model/sheet_event.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const LoadFavoritiesEvent(favorities: []));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(context.l10n.profile),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomElevatedButton(
              padding: EdgeInsets.symmetric(horizontal: 6),
              onPressed: () {
                context.read<SheetBloc>().add(
                  ShowSheetEvent(JetonPackageBottomSheet()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.diamond_outlined),
                  SizedBox(width: 5),
                  Text(
                    context.l10n.limitedOffer,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Spacers.verticalLarge,

                  ProfileArea(state: state),

                  Spacers.verticalLarge,

                  FavoritiesArea(),

                  Spacers.verticalLarge,

                  CustomElevatedButton(
                    backgroundColor: context.theme.colorScheme.outline,
                    onPressed: () {
                      context.push('/settings');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(width: 8),
                        Text(context.l10n.settings),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Logout butonu
                  CustomElevatedButton(
                    onPressed: () => showLogoutDialog(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(width: 8),
                        Text(context.l10n.logout),
                      ],
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
