import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/consts/storage_keys.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/infrastructure/storage/key_value_store.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _keyStore = GetIt.I<KeyValueStore>();

  @override
  Future<bool?> hasCompletedLogin() async {
    return await _keyStore.read<bool>(StorageKeys.hasCompletedLogin,
        defaultValue: false) as bool;
  }

  @override
  FutureOr<void> completeLogin({bool isCompleteLogin = true}) async {
    await _keyStore.write(StorageKeys.hasCompletedLogin, isCompleteLogin);
  }

  @override
  Future<void> logoutUser() async {
    await _keyStore.write(StorageKeys.hasCompletedLogin, false);
    await _keyStore.write(StorageKeys.profile, '');
  }

  @override
  Future<void> saveProfile(String profile) async =>
      await _keyStore.write(StorageKeys.profile, profile);

  @override
  Future<String?> getProfile() async =>
      await _keyStore.read<String>(StorageKeys.profile, defaultValue: '');
}
