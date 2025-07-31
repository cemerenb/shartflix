// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get login => 'Giriş Yap';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get name => 'İsim';

  @override
  String get loginButton => 'Giriş Yap';

  @override
  String get registerButton => 'Kayıt Ol';

  @override
  String get dontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get alreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get loginSuccess => 'Giriş başarılı';

  @override
  String get registerSuccess => 'Kayıt başarılı';

  @override
  String get loginError => 'Giriş başarısız';

  @override
  String get registerError => 'Kayıt başarısız';

  @override
  String get emailRequired => 'E-posta gerekli';

  @override
  String get passwordRequired => 'Şifre gerekli';

  @override
  String get nameRequired => 'İsim gerekli';

  @override
  String get passwordsNotMatch => 'Şifreler uyuşmuyor';

  @override
  String get invalidEmail => 'Geçersiz e-posta formatı';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get profile => 'Profil';

  @override
  String get discover => 'Keşfet';

  @override
  String get favorites => 'Favoriler';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get welcome => 'Smartflix\'e Hoş Geldiniz';
}
