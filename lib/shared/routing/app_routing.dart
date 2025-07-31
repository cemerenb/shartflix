import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/bloc/auth_bloc.dart';
import 'package:shartflix/features/auth/bloc/auth_state.dart';
import 'package:shartflix/features/auth/view/login_screen.dart';
import 'package:shartflix/features/auth/view/register_screen.dart';
import 'package:shartflix/features/auth/view/upload_photo_screen.dart';
import 'package:shartflix/features/home/view/home_screen.dart';
import 'package:shartflix/features/main/view/main_screen.dart';
import 'package:shartflix/features/profile/view/profile_screen.dart';
import 'package:shartflix/features/splash/splash_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(AuthBloc authBloc) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',
      redirect: (context, state) {
        final authState = authBloc.state;
        final isOnAuthPage =
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/upload-photo';
        final isOnSplash = state.matchedLocation == '/splash';

        // Splash ekranındayken yönlendirme yapma
        if (isOnSplash) return null;

        if (authState is AuthAuthenticated &&
            isOnAuthPage &&
            state.matchedLocation != '/register' &&
            state.matchedLocation != '/upload-photo') {
          return '/home';
        }

        // Kullanıcı giriş yapmamışsa ve auth sayfasında değilse login'e yönlendir
        if (authState is AuthUnauthenticated && !isOnAuthPage) {
          return '/login';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/upload-photo',
          builder: (context, state) => const UploadPhotoScreen(),
        ),

        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) => MainScreen(child: child),
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
