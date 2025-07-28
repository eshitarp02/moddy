part of 'log_new_activity_bloc.dart';

abstract class LogNewActivityEvent extends Equatable {
  const LogNewActivityEvent();

  @override
  List<Object?> get props => [];
}

class LogNewActivityOnLoadEvent extends LogNewActivityEvent {
  const LogNewActivityOnLoadEvent();
}

class LogNewActivityDetailsUpdateEvent extends LogNewActivityEvent {
  final String? activity;
  final String? description;
  final String? bookmark;
  final String? mood;

  const LogNewActivityDetailsUpdateEvent({
    this.activity,
    this.description,
    this.bookmark,
    this.mood,
  });

  @override
  List<Object?> get props => [
        activity,
        description,
        bookmark,
        mood,
      ];
}

class LogNewActivitySubmitEvent extends LogNewActivityEvent {}
