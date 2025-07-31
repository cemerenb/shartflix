import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/bloc/auth_bloc.dart';
import 'package:shartflix/features/auth/bloc/auth_event.dart';
import 'package:shartflix/features/auth/bloc/auth_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/widgets/custom_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile), centerTitle: true),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white.withAlpha(55),
                          backgroundImage: state.user.photoUrl != null
                              ? NetworkImage(state.user.photoUrl!)
                              : null,
                          child: state.user.photoUrl == ""
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),

                        Text(
                          state.user.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacers.small,

                        Text(
                          state.user.email,
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 16,
                          ),
                        ),
                        Spacers.large,

                        state.user.photoUrl == ""
                            ? CustomContainer(
                                child: Text(
                                  "Henüz bir fotoğraf yüklemediniz. Bazı özellikleri kullanabilmek için fotoğraf yüklemeniz gerekiyor.",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox(),
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
