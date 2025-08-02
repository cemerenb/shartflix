import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_event.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/widgets/custom_container.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.diamond_outlined),
                  SizedBox(width: 5),
                  Text(
                    'Sınırlı Teklif',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.white,
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
                children: [
                  Spacers.verticalLarge,
                  SizedBox(
                    width: context.screenWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Buton yukarı hizalı kalsın
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child:
                                    state.user.photoUrl != null &&
                                        state.user.photoUrl!.isNotEmpty
                                    ? Image.network(
                                        state.user.photoUrl!,
                                        fit: BoxFit.fill,
                                        width: 70,
                                        height: 70,
                                      )
                                    : Container(
                                        width: 70,
                                        height: 70,
                                        color: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.person,
                                          size: 40,
                                        ),
                                      ),
                              ),
                              Spacers.horizontalMedium,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.user.name,
                                      style: context.textTheme.titleMedium,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                    Text(
                                      "ID: ${state.user.id}",
                                      style: context.textTheme.labelMedium,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: 40,
                              child: CustomElevatedButton(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                borderRadius: 10,
                                height: 50,
                                onPressed: () {
                                  GoRouter.of(context).push('/upload-photo');
                                },
                                child: Text(context.l10n.uploadPhoto),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.favorite),
                          title: Text(context.l10n.favorites),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Settings'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            _showLanguageSelector(context);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text('Theme'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            _showThemeSelector(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      icon: const Icon(Icons.logout),
                      label: Text(context.l10n.logout),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.logout),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              child: Text(context.l10n.logout),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Türkçe'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Dark'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Light'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('System'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
