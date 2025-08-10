import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/utils/app_config.dart';
import 'package:to_do_app/domain/model/request/signup_request_model.dart';
import 'package:to_do_app/domain/model/response/signup_response_model.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/infrastructure/network/api_client.dart';
import 'package:to_do_app/infrastructure/network/api_endpoints.dart';
import 'package:to_do_app/infrastructure/network/network_exception.dart';
import 'package:to_do_app/infrastructure/network/repository_exception.dart';

import 'sign_up_api.dart';

class SignUpApiImpl extends SignUpApi {
  final apiClient = GetIt.I<ApiClient>();

  AppConfig get _appConfig => GetIt.I<AppConfig>();
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  @override
  Future<SignUpResponseModel?> registerUser({
    required SignUpRequestModel signUpRequestModel,
  }) async {
    final SignUpResponseModel signUpResponseModel;
    try {
      final response = await apiClient.post(
        '${_appConfig.baseUrl}${ApiEndPoints.signUp}',
        data: signUpRequestModel.toJson(),
        options: Options(
          method: 'POST',
        ),
      );

      signUpResponseModel = SignUpResponseModel.fromJson(response?.data);
      return signUpResponseModel;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
