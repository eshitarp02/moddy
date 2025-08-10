import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/enums/env.dart';
import 'package:to_do_app/core/utils/app_config.dart';
import 'package:to_do_app/data/api/login/login_api.dart';
import 'package:to_do_app/data/api/login/login_api_impl.dart';
import 'package:to_do_app/data/api/signup/sign_up_api.dart';
import 'package:to_do_app/data/api/signup/sign_up_api_impl.dart';
import 'package:to_do_app/data/log_activity/log_activity_api.dart';
import 'package:to_do_app/data/log_activity/log_activity_api_impl.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository_impl.dart';
import 'package:to_do_app/domain/repositories/log_activity/log_activity_repository.dart';
import 'package:to_do_app/domain/repositories/log_activity/log_activity_repository_impl.dart';
import 'package:to_do_app/domain/repositories/login/login_repository.dart';
import 'package:to_do_app/domain/repositories/login/login_repository_impl.dart';
import 'package:to_do_app/domain/repositories/signup/signup_repository.dart';
import 'package:to_do_app/domain/repositories/signup/signup_repository_impl.dart';
import 'package:to_do_app/infrastructure/network/api_client.dart';
import 'package:to_do_app/infrastructure/storage/key_value_store.dart';
import 'package:to_do_app/infrastructure/storage/key_value_store_impl.dart';

typedef AppRunner = FutureOr<void> Function();

class Injector {
  static Future<void> init({
    required AppRunner appRunner,
    required Environment env,
  }) async {
    final appConfig = AppConfig.init(env: env);

    await _initDependencies(appConfig: await appConfig);
    appRunner();
  }

  static Future<void> _initDependencies({required AppConfig appConfig}) async {
    await _injectUtils(appConfig);
    await _injectServices(appConfig);
    _injectRepositories();
    _injectApi();
    await GetIt.I.allReady();
  }
}

/// Register tools and utils
FutureOr<void> _injectUtils(AppConfig appConfig) {
  GetIt.I.registerSingleton<AppConfig>(appConfig);
  GetIt.I.registerLazySingleton<Dio>(() => Dio());
  GetIt.I.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  GetIt.I.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  GetIt.I.registerLazySingleton<ApiClient>(
    () => ApiClient(GetIt.I<Dio>(), appConfig.baseUrl),
  );
  GetIt.I.registerLazySingleton<KeyValueStore>(
    () => KeyValueStoreImpl(GetIt.I<SharedPreferences>()),
  );
}

/// Register repository implementation
void _injectRepositories() {
  GetIt.I.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  GetIt.I.registerLazySingleton<SignupRepository>(() => SignupRepositoryImpl());
  GetIt.I.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl());
  GetIt.I.registerLazySingleton<LogActivityRepository>(
      () => LogActivityRepositoryImpl());
}

void _injectApi() {
  GetIt.I.registerLazySingleton<SignUpApi>(() => SignUpApiImpl());
  GetIt.I.registerLazySingleton<LoginApi>(() => LoginApiImpl());
  GetIt.I.registerLazySingleton<LogActivityApi>(() => LogActivityApiImpl());
}

/// Register Service related implementation
FutureOr<void> _injectServices(AppConfig appConfig) async {}
