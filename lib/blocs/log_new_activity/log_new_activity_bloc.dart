import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/domain/model/request/log_new_activity_request_model.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/domain/repositories/log_activity/log_activity_repository.dart';

part 'log_new_activity_event.dart';
part 'log_new_activity_state.dart';

class LogNewActivityBloc
    extends Bloc<LogNewActivityEvent, LogNewActivityState> {
  final _authRepo = GetIt.I<AuthRepository>();
  final _logActivity = GetIt.I<LogActivityRepository>();

  LogNewActivityBloc() : super(LogNewActivityInitial()) {
    on<LogNewActivityOnLoadEvent>(_onLoadLogNewActivity);
    on<LogNewActivityDetailsUpdateEvent>(_onLogNewActivityDetailsUpdate);
    on<LogNewActivitySubmitEvent>(_onLogNewActivitySubmit);
  }

  FutureOr<void> _onLoadLogNewActivity(
      LogNewActivityOnLoadEvent event, Emitter<LogNewActivityState> emit) {
    emit(
      LogNewActivityOnLoadState(),
    );
  }

  FutureOr<void> _onLogNewActivityDetailsUpdate(
      LogNewActivityDetailsUpdateEvent event,
      Emitter<LogNewActivityState> emit) {
    final castState = state as LogNewActivityOnLoadState;

    emit(
      castState.copyWith(
        activity: event.activity ?? castState.activity,
        description: event.description ?? castState.description,
        bookmark: event.bookmark ?? castState.bookmark,
        mood: event.mood ?? castState.mood,
      ),
    );
  }

  FutureOr<void> _onLogNewActivitySubmit(LogNewActivitySubmitEvent event,
      Emitter<LogNewActivityState> emit) async {
    final castState = state as LogNewActivityOnLoadState;

    var errorMessage = '';
    if (castState.activity.isEmpty) {
      errorMessage = 'Please enter Activity';
    } else if (castState.description.isEmpty) {
      errorMessage = 'Please enter description';
    } else if (castState.bookmark.isEmpty) {
      errorMessage = 'Please enter bookmark';
    }

    if (errorMessage.isNotEmpty) {
      emit(
        castState.copyWith(
          errorMessage: errorMessage,
        ),
      );
    } else {
      emit(
        castState.copyWith(
          isLogNewActivityInProgress: true,
        ),
      );

      // get user Id from shared preferences
      final userId = await _authRepo.getProfile();
      final logNewActivityRequestModel = LogNewActivityRequestModel(
        userId: userId,
        activityType: castState.activity,
        description: castState.description,
        bookmark: castState.bookmark,
        mood: castState.mood,
        timestamp: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(
          (DateTime.now()),
        ),
      );

      final logNewActivityResponse = await _logActivity.logNewActivity(
        logNewActivityRequestModel: logNewActivityRequestModel,
      );
      if (logNewActivityResponse != null &&
          (logNewActivityResponse.activityId ?? '').isNotEmpty) {
        emit(
          LogNewActivitySuccess(),
        );
      } else {
        emit(
          castState.copyWith(
            errorMessage: logNewActivityResponse?.error,
            isLogNewActivityInProgress: false,
          ),
        );
      }
    }
  }
}
