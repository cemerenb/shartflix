import 'package:bloc/bloc.dart';
import 'package:shartflix/features/settings/view_model/settings_event.dart';
import 'package:shartflix/features/settings/view_model/settings_state.dart';
import 'package:shartflix/shared/utils/storage.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
    : super(SettingsState(themeMode: 'system', languageCode: 'tr')) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadSettings(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final theme = await StorageService.getThemeMode() ?? 'system';
    final lang = await StorageService.getLanguage() ?? 'tr';

    emit(state.copyWith(themeMode: theme, languageCode: lang));
  }

  Future<void> _onChangeTheme(
    ChangeThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await StorageService.saveThemeMode(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await StorageService.saveLanguage(event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }
}
