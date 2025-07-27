part of 'app_settings_bloc.dart';

abstract class AppSettingsState extends Equatable {
  const AppSettingsState();

  @override
  List<Object?> get props => [];
}

class AppSettingsInitialState extends AppSettingsState {
  const AppSettingsInitialState();
}

class AppSettingsOnLoadState extends AppSettingsState {
  final ThemeMode themeMode;
  const AppSettingsOnLoadState({
    required this.themeMode,
  });

  @override
  List<Object> get props => [
        themeMode,
      ];
}
