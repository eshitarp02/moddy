import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_store.dart';

class KeyValueStoreImpl extends KeyValueStore {
  final SharedPreferences preferences;
  FlutterSecureStorage storage;
  KeyValueStoreImpl(this.preferences,
      {this.storage = const FlutterSecureStorage()}) {
    init();
  }
  Future<void> init() async {
    if (preferences.getBool('first_run') ?? true) {
      await storage.deleteAll();
      await preferences.setBool('first_run', false);
    }
  }

  @override
  FutureOr<void> write(String key, dynamic value) async {
    final storeValue = jsonEncode(value);
    debugPrint(storeValue);
    await storage.write(key: key, value: storeValue);
  }

  @override
  FutureOr<T?> read<T>(String key, {T? defaultValue}) async {
    final returnValue = await storage.read(key: key);
    if (returnValue != null) {
      final dynamic newValue = jsonDecode(returnValue);
      debugPrint(newValue.toString());
      return jsonDecode(returnValue) as T?;
    } else {
      return defaultValue;
    }
  }

  @override
  FutureOr<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
