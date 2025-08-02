import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final String themeMode;
  final String languageCode;

  const SettingsState({required this.themeMode, required this.languageCode});

  SettingsState copyWith({String? themeMode, String? languageCode}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object> get props => [themeMode, languageCode];
}
