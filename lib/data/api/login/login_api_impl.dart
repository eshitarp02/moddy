import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/utils/app_config.dart';
import 'package:to_do_app/domain/model/request/login_request_model.dart';
import 'package:to_do_app/domain/model/response/login_response_model.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/infrastructure/network/api_client.dart';
import 'package:to_do_app/infrastructure/network/api_endpoints.dart';
import 'package:to_do_app/infrastructure/network/network_exception.dart';
import 'package:to_do_app/infrastructure/network/repository_exception.dart';
import 'login_api.dart';

class LoginApiImpl extends LoginApi {
  final apiClient = GetIt.I<ApiClient>();

  AppConfig get _appConfig => GetIt.I<AppConfig>();
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  @override
  Future<LoginResponseModel?> loginRequest({
    required LoginRequestModel loginRequestModel,
  }) async {
    final LoginResponseModel loginResponseModel;
    try {
      final response = await apiClient.post(
        '${_appConfig.baseUrl}${ApiEndPoints.login}',
        data: loginRequestModel.toJson(),
        options: Options(
          method: 'POST',
        ),
      );

      loginResponseModel = LoginResponseModel.fromJson(response?.data);
      return loginResponseModel;

    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
