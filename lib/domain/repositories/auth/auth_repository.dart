import 'dart:async';

abstract interface class AuthRepository {
  FutureOr<bool?> hasCompletedLogin();

  FutureOr<void> completeLogin({bool isCompleteLogin = true});

  Future<void> logoutUser();

  Future<void> saveProfile(String profile);

  Future<String?> getProfile();
}
