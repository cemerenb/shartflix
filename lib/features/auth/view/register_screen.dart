import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_event.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/features/auth/widget/social_login.dart';
import 'package:shartflix/features/auth/widget/user_agreement_text.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/shared/utils/validators/validator.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';
import 'package:shartflix/widgets/custom_password_field.dart';
import 'package:shartflix/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthRegisterRequested(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    } else {
      CustomSnackbar.errorSnackbar(
        context: context,
        message: context.l10n.checkRegisterFields,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            state.user.photoUrl == ""
                ? context.push('/upload-photo')
                : context.go('/home');
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
                              context.l10n.register,
                              style: context.textTheme.headlineMedium,
                              textAlign: TextAlign.center,
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
                            Spacers.large,

                            CustomTextField(
                              controller: _nameController,
                              label: context.l10n.fullName,
                              iconAsset: 'assets/icon/person.png',
                              validator: (value) =>
                                  Validators.fullName(value, context),
                            ),
                            Spacers.medium,

                            CustomTextField(
                              controller: _emailController,
                              label: context.l10n.email,
                              iconAsset: 'assets/icon/email.png',

                              validator: (value) => Validators.email(
                                context,
                                _emailController.text.trim(),
                              ),
                            ),
                            Spacers.medium,

                            CustomPasswordField(
                              controller: _passwordController,
                              label: context.l10n.password,
                              iconAsset: "assets/icon/password.png",

                              validator: (value) => Validators.password(
                                _passwordController.text,
                                context,
                              ),
                            ),
                            Spacers.medium,

                            CustomPasswordField(
                              controller: _confirmPasswordController,
                              label: context.l10n.confirmPassword,
                              iconAsset: "assets/icon/password.png",

                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return context.l10n.passwordsNotMatch;
                                }
                                return null;
                              },
                            ),
                            Spacers.large,

                            UserAgreementText(),
                            Spacers.large,

                            CustomElevatedButton(
                              onPressed: isLoading ? null : _register,
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      context.l10n.register,
                                      style: context.textTheme.bodyLarge,
                                    ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Spacers.large,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialLogin(
                                  imagePath: 'assets/icon/google.png',
                                ),
                                Spacers.horizontalMedium,
                                SocialLogin(imagePath: 'assets/icon/apple.png'),
                                Spacers.horizontalMedium,
                                SocialLogin(
                                  imagePath: 'assets/icon/facebook.png',
                                ),
                              ],
                            ),
                            Spacers.extraLarge,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(context.l10n.alreadyHaveAccount),
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => context.go('/login'),
                                  child: Text(
                                    context.l10n.loginButton,
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
