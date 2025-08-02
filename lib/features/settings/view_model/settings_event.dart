import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final String themeMode;
  ChangeThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String languageCode;
  ChangeLanguageEvent(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
