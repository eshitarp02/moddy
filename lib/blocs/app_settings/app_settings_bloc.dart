import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/consts/storage_keys.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final _sharedPref = GetIt.I<SharedPreferences>();
  AppSettingsBloc() : super(const AppSettingsInitialState()) {
    on<AppSettingsOnLoadEvent>(_checkLanguageState);
  }

  FutureOr<void> _checkLanguageState(
    AppSettingsOnLoadEvent event,
    Emitter<AppSettingsState> emit,
  ) async {
    if (event.themeMode != null) {
      await _sharedPref.setString(
        StorageKeys.themeSelected,
        event.themeMode!.name,
      );
    }

    /// Get Theme
    final themeMode =
        _sharedPref.getString(StorageKeys.themeSelected) ?? 'system';
    ThemeMode theme;
    switch (themeMode) {
      case 'light':
        theme = ThemeMode.light;
        break;
      case 'dark':
        theme = ThemeMode.dark;
        break;
      default:
        theme = ThemeMode.system;
        break;
    }

    /// Emit provided Theme and Locale
    emit(AppSettingsOnLoadState(themeMode: theme));
  }
}
