import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/log_activity/log_activity_api.dart';
import 'package:to_do_app/domain/model/request/log_new_activity_request_model.dart';
import 'package:to_do_app/domain/model/response/log_new_activity_response_model.dart';
import 'package:to_do_app/domain/repositories/log_activity/log_activity_repository.dart';

class LogActivityRepositoryImpl extends LogActivityRepository {
  final logActivity = GetIt.I<LogActivityApi>();

  @override
  Future<LogNewActivityResponseModel?> logNewActivity({
    required LogNewActivityRequestModel logNewActivityRequestModel,
  }) {
    return logActivity.logNewActivity(
      logNewActivityRequestModel: logNewActivityRequestModel,
    );
  }
}
