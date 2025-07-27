part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeOnLoadState extends HomeState {
  const HomeOnLoadState();

  @override
  List<Object?> get props => [];
}
