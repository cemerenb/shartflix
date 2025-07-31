// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get name => 'Name';

  @override
  String get loginButton => 'Login';

  @override
  String get registerButton => 'Register';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get loginError => 'Login failed';

  @override
  String get registerError => 'Registration failed';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get discover => 'Discover';

  @override
  String get favorites => 'Favorites';

  @override
  String get logout => 'Logout';

  @override
  String get loading => 'Loading...';

  @override
  String get welcome => 'Welcome to Smartflix';
}
