import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_new_activity_event.dart';

part 'log_new_activity_state.dart';

class LogNewActivityBloc
    extends Bloc<LogNewActivityEvent, LogNewActivityState> {
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

  FutureOr<void> _onLogNewActivitySubmit(
      LogNewActivitySubmitEvent event, Emitter<LogNewActivityState> emit) {
    final castState = state as LogNewActivityOnLoadState;

    var errorMessage = '';
    if (castState.activity.isEmpty) {
      errorMessage = 'Please enter Activity';
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
        LogNewActivitySuccess(),
      );
    }
  }
}
