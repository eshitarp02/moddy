import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/utils/app_config.dart';
import 'package:to_do_app/domain/model/request/log_new_activity_request_model.dart';
import 'package:to_do_app/domain/model/response/log_new_activity_response_model.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/infrastructure/network/api_client.dart';
import 'package:to_do_app/infrastructure/network/api_endpoints.dart';
import 'package:to_do_app/infrastructure/network/network_exception.dart';
import 'package:to_do_app/infrastructure/network/repository_exception.dart';

import 'log_activity_api.dart';

class LogActivityApiImpl extends LogActivityApi {
  final apiClient = GetIt.I<ApiClient>();

  AppConfig get _appConfig => GetIt.I<AppConfig>();
  final AuthRepository authRepository = GetIt.I<AuthRepository>();

  @override
  Future<LogNewActivityResponseModel?> logNewActivity({
    required LogNewActivityRequestModel logNewActivityRequestModel,
  }) async {
    final LogNewActivityResponseModel logNewActivityResponseModel;
    try {
      final response = await apiClient.post(
        '${_appConfig.baseUrl}${ApiEndPoints.logNewActivity}',
        data: logNewActivityRequestModel.toJson(),
        options: Options(
          method: 'POST',
        ),
      );

      logNewActivityResponseModel =
          LogNewActivityResponseModel.fromJson(response?.data);
      return logNewActivityResponseModel;
    } on NetworkException catch (e) {
      throw RepositoryException(e.message);
    }
  }
}
