part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();
  @override
  List<Object?> get props => [];
}

class AppSettingsOnLoadEvent extends AppSettingsEvent {
  final Locale? locale;
  final ThemeMode? themeMode;
  const AppSettingsOnLoadEvent({
    this.locale,
    this.themeMode,
  });
  @override
  List<Object?> get props => [
        locale,
        themeMode,
      ];
}
