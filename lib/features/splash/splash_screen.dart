import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_event.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.go('/home');
              }
            });
          } else if (state is AuthUnauthenticated) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.go('/login');
              }
            });
          }
        },
        child: SizedBox(
          width: context.screenWidth,
          height: context.screenHeight,
          child: Image.asset(
            'assets/logo/SinFlixSplash.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
