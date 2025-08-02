import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_event.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/features/auth/widget/social_login.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/shared/utils/validators/validator.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';
import 'package:shartflix/widgets/custom_password_field.dart';
import 'package:shartflix/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  height: context.screenHeight * 0.9,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              context.l10n.welcome,
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineMedium,
                            ),
                            Spacers.medium,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.screenWidth * 0.1,
                              ),
                              child: Text(
                                context.l10n.loremIpsum,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            Spacers.verticalExtraLarge,
                            CustomTextField(
                              controller: _emailController,
                              label: context.l10n.email,
                              iconAsset: 'assets/icon/email.png',
                              validator: (p0) {
                                return Validators.email(
                                  context,
                                  _emailController.text.trim(),
                                );
                              },
                            ),
                            Spacers.extraLarge,
                            CustomPasswordField(
                              controller: _passwordController,
                              label: context.l10n.password,
                              iconAsset: "assets/icon/password.png",
                              validator: (p0) {
                                return Validators.password(
                                  _passwordController.text,
                                  context,
                                );
                              },
                            ),
                            Spacers.extraLarge,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => context.go('/forgot-password'),
                                  child: Text(context.l10n.forgotPassword),
                                ),
                              ],
                            ),
                            Spacers.extraLarge,
                            CustomElevatedButton(
                              onPressed: isLoading ? null : _login,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      context.l10n.loginButton,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(color: AppTheme.white),
                                    ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Spacers.verticalExtraLarge,
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialLogin(
                                  imagePath: 'assets/icon/google.png',
                                ),
                                SocialLogin(imagePath: 'assets/icon/apple.png'),
                                SocialLogin(
                                  imagePath: 'assets/icon/facebook.png',
                                ),
                              ],
                            ),
                            Spacers.verticalExtraLarge,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.l10n.dontHaveAccount,
                                  style: context.textTheme.labelLarge,
                                ),
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => context.go('/register'),
                                  child: Text(
                                    context.l10n.register,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacers.large,
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
