import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shartflix/features/auth/bloc/auth_bloc.dart';
import 'package:shartflix/features/auth/repository/auth_repository.dart';
import 'package:shartflix/l10n/app_localizations.dart';
import 'package:shartflix/shared/routing/app_routing.dart';
import 'package:shartflix/shared/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(_authRepository),
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();

          return MaterialApp.router(
            title: 'Smartflix',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('tr')],
            locale: const Locale('en'),
            routerConfig: AppRouter.router(authBloc),
          );
        },
      ),
    );
  }
}
