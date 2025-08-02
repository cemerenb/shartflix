import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/repository/auth_repository.dart';
import 'package:shartflix/features/home/repository/home_repository.dart';
import 'package:shartflix/features/home/view_model/home_bloc.dart';
import 'package:shartflix/features/profile/repository/profile_repository.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/settings/view_model/settings_bloc.dart';
import 'package:shartflix/features/settings/view_model/settings_event.dart';
import 'package:shartflix/features/settings/view_model/settings_state.dart';
import 'package:shartflix/features/sheet/view_model/sheet_bloc.dart';
import 'package:shartflix/l10n/app_localizations.dart';
import 'package:shartflix/shared/routing/app_routing.dart';
import 'package:shartflix/shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthRepository authRepository = AuthRepository();
  final HomeRepository homeRepository = HomeRepository();
  final ProfileRepository profileRepository = ProfileRepository();

  final settingsBloc = SettingsBloc()..add(LoadSettingsEvent());

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<HomeRepository>.value(value: homeRepository),
        RepositoryProvider<ProfileRepository>.value(value: profileRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepository)),
          BlocProvider(create: (_) => SheetBloc()),
          BlocProvider<HomeBloc>(
            create: (context) =>
                HomeBloc(homeRepository: context.read<HomeRepository>()),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider<SettingsBloc>(create: (_) => settingsBloc),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final authBloc = context.read<AuthBloc>();

        return MaterialApp.router(
          title: 'Shartflix',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _mapThemeMode(state.themeMode),
          locale: Locale(state.languageCode),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('tr')],
          routerConfig: AppRouter.router(authBloc),
        );
      },
    );
  }

  ThemeMode _mapThemeMode(String themeMode) {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
