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

  const LogNewActivityOnLoadState({
    this.activity = '',
    this.description = '',
    this.bookmark = '',
    this.mood,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        activity,
        description,
        bookmark,
        mood,
        errorMessage,
      ];

  LogNewActivityOnLoadState copyWith({
    String? activity,
    String? description,
    String? bookmark,
    String? mood,
    String? errorMessage,
  }) {
    return LogNewActivityOnLoadState(
      activity: activity ?? this.activity,
      description: description ?? this.description,
      bookmark: bookmark ?? this.bookmark,
      mood: mood ?? this.mood,
      errorMessage: errorMessage ?? '',
    );
  }
}

final class LogNewActivitySuccess extends LogNewActivityState {}
