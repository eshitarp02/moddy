import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/utils/app_config.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/routes/routes.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor({required this.dio});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final appConfig = GetIt.I<AppConfig>();

    options.baseUrl = appConfig.baseUrl;
    options.headers['Content-Type'] = 'application/json';
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final authRepository = GetIt.I<AuthRepository>();
    debugPrint('Error Code - ${err.response?.statusCode}');
    if (err.response?.statusCode == 401) {
      try {
        debugPrint('401 error- Invalid Signature');
        // clear all saved data
        await authRepository.logoutUser();
        router.goNamed(Routes.login.name);
        return;
      } catch (e, st) {
        debugPrint('Error-$st');
      }
    } else if (err.response?.statusCode == 403) {
      // clear all saved data
      await authRepository.logoutUser();
      router.goNamed(Routes.login.name);
      return;
    }
    return handler.next(err);
  }
}
