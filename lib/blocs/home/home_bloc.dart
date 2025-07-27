import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeOnLoadEvent>(_onLoadHome);
  }

  FutureOr<void> _onLoadHome(
      HomeOnLoadEvent event, Emitter<HomeState> emit) async {
    emit(
      HomeOnLoadState(),
    );
  }
}
