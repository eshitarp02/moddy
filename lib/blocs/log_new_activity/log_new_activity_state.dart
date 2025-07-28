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
  final String bookmark;
  final String? mood;
  final String errorMessage;

  const LogNewActivityOnLoadState({
    this.activity = '',
    this.bookmark = '',
    this.mood,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        activity,
        bookmark,
        mood,
        errorMessage,
      ];

  LogNewActivityOnLoadState copyWith({
    String? activity,
    String? bookmark,
    String? mood,
    String? errorMessage,
  }) {
    return LogNewActivityOnLoadState(
      activity: activity ?? this.activity,
      bookmark: bookmark ?? this.bookmark,
      mood: mood ?? this.mood,
      errorMessage: errorMessage ?? '',
    );
  }
}

final class LogNewActivitySuccess extends LogNewActivityState {}
