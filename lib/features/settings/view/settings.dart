import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/settings/view_model/settings_bloc.dart';
import 'package:shartflix/features/settings/view_model/settings_event.dart';
import 'package:shartflix/features/settings/widget/agreements.dart';
import 'package:shartflix/features/settings/widget/section_tile.dart';
import 'package:shartflix/features/settings/widget/settings_tile.dart';
import 'package:shartflix/features/settings/widget/switch_tile.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/shared/utils/storage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'tr';
  String _selectedTheme = 'light';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final lang = await StorageService.getLanguage();
    final theme = await StorageService.getThemeMode();

    setState(() {
      _selectedLanguage = lang ?? 'tr';
      _selectedTheme = theme ?? 'light';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(context.l10n.settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(context, context.l10n.general),
            Spacers.verticalSmall,

            buildSettingsTile(
              context: context,
              icon: Icons.language,
              title: context.l10n.language,
              subtitle: _getLanguageDisplayName(_selectedLanguage),
              onTap: () => _showLanguageDialog(context),
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.palette,
              title: context.l10n.theme,
              subtitle: _getThemeDisplayName(_selectedTheme),
              onTap: () => _showThemeDialog(context),
            ),

            buildSectionTitle(context, context.l10n.application),

            buildSwitchTile(
              context: context,
              icon: Icons.notifications,
              title: context.l10n.notification,
              subtitle: context.l10n.getNotification,
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.menu_book_sharp,
              title: context.l10n.data,
              subtitle: context.l10n.getData,
              onTap: () {
                CustomSnackbar.soonSnackbar(
                  context: context,
                  message: context.l10n.dataSettingsSoon,
                );
              },
            ),

            buildSectionTitle(context, context.l10n.accountAndSecurity),

            buildSettingsTile(
              context: context,

              icon: Icons.security,
              title: context.l10n.securitySettings,
              subtitle: context.l10n.securitySettingsTest,
              onTap: () {
                CustomSnackbar.soonSnackbar(
                  context: context,
                  message: context.l10n.securitySettingsSoon,
                );
              },
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.lock,
              title: context.l10n.changePassword,
              subtitle: context.l10n.changePasswordText,
              onTap: () {
                CustomSnackbar.soonSnackbar(
                  context: context,
                  message: context.l10n.changePasswordSoon,
                );
              },
            ),

            Spacers.verticalMedium,

            buildSectionTitle(context, context.l10n.help),
            Spacers.verticalSmall,

            buildSettingsTile(
              context: context,

              icon: Icons.help,
              title: context.l10n.helpCenter,
              subtitle: context.l10n.sss,
              onTap: () {
                CustomSnackbar.soonSnackbar(
                  context: context,
                  message: context.l10n.helpCenterSoon,
                );
              },
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.description,
              title: context.l10n.userAgreement,
              subtitle: context.l10n.userAgreementText,
              onTap: () => showUserAgreementDialog(context),
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.privacy_tip,
              title: context.l10n.userAgreement,
              subtitle: context.l10n.kvkk,
              onTap: () => showPrivacyPolicyDialog(context),
            ),

            buildSettingsTile(
              context: context,

              icon: Icons.info,
              title: context.l10n.aboutApp,
              subtitle: '${context.l10n.version} 1.0.0',
              onTap: () => _showAboutDialog(context),
            ),

            Spacers.verticalLarge,
          ],
        ),
      ),
    );
  }

  String _getLanguageDisplayName(String languageCode) {
    switch (languageCode) {
      case 'tr':
        return context.l10n.turkish;
      case 'en':
        return context.l10n.english;
      default:
        return context.l10n.turkish;
    }
  }

  String _getThemeDisplayName(String theme) {
    switch (theme) {
      case 'light':
        return context.l10n.lightTheme;
      case 'dark':
        return context.l10n.darkTheme;
      case 'system':
        return context.l10n.system;
      default:
        return context.l10n.lightTheme;
    }
  }

  void _showLanguageDialog(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    final selectedLang = bloc.state.languageCode;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(context.l10n.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(context.l10n.turkish),
                value: 'tr',
                groupValue: selectedLang,
                activeColor: AppTheme.accentColor,
                onChanged: (value) {
                  bloc.add(ChangeLanguageEvent(value!));
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text(context.l10n.english),
                value: 'en',
                groupValue: selectedLang,
                activeColor: AppTheme.accentColor,

                onChanged: (value) {
                  bloc.add(ChangeLanguageEvent(value!));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    final selectedTheme = bloc.state.themeMode;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(context.l10n.selectTheme),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(context.l10n.lightTheme),
                value: 'light',
                groupValue: selectedTheme,
                activeColor: AppTheme.accentColor,

                onChanged: (value) {
                  bloc.add(ChangeThemeEvent(value!));
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text(context.l10n.darkTheme),
                value: 'dark',
                groupValue: selectedTheme,
                activeColor: AppTheme.accentColor,

                onChanged: (value) {
                  bloc.add(ChangeThemeEvent(value!));
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text(context.l10n.system),
                value: 'system',
                groupValue: selectedTheme,
                activeColor: AppTheme.accentColor,

                onChanged: (value) {
                  bloc.add(ChangeThemeEvent(value!));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Shartflix',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.movie, size: 48),
      children: [Text('© 2025 Shartflix. ${context.l10n.allRights}')],
    );
  }
}
