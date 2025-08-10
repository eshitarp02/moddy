part of 'log_new_activity_bloc.dart';

abstract class LogNewActivityState extends Equatable {
  const LogNewActivityState();

  @override
  List<Object?> get props => [];
}

final class LogNewActivityInitial extends LogNewActivityState {
  @override
  List<Object> get props => [];
}

final class LogNewActivityOnLoadState extends LogNewActivityState {
  final String activity;
  final String description;
  final String bookmark;
  final String? mood;
  final String errorMessage;
  final bool isLogNewActivityInProgress;

  const LogNewActivityOnLoadState({
    this.activity = '',
    this.description = '',
    this.bookmark = '',
    this.mood,
    this.errorMessage = '',
    this.isLogNewActivityInProgress = false,
  });

  @override
  List<Object?> get props => [
        activity,
        description,
        bookmark,
        mood,
        errorMessage,
        isLogNewActivityInProgress,
      ];

  LogNewActivityOnLoadState copyWith({
    String? activity,
    String? description,
    String? bookmark,
    String? mood,
    String? errorMessage,
    bool? isLogNewActivityInProgress,
  }) {
    return LogNewActivityOnLoadState(
      activity: activity ?? this.activity,
      description: description ?? this.description,
      bookmark: bookmark ?? this.bookmark,
      mood: mood ?? this.mood,
      errorMessage: errorMessage ?? '',
      isLogNewActivityInProgress:
          isLogNewActivityInProgress ?? this.isLogNewActivityInProgress,
    );
  }
}

final class LogNewActivitySuccess extends LogNewActivityState {}
