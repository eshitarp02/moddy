import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/domain/model/request/login_request_model.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/domain/repositories/login/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authRepo = GetIt.I<AuthRepository>();
  final _loginRepo = GetIt.I<LoginRepository>();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginOnLoadEvent>(_onLogin);
    on<LoginPasswordVisibleEvent>(_onPasswordVisible);
    on<LoginDetailsUpdateEvent>(_onLoginDetailsUpdate);
    on<LoginSubmitEvent>(_onLoginSubmit);
  }

  FutureOr<void> _onLogin(
      LoginOnLoadEvent event, Emitter<LoginState> emit) async {
    emit(
      LoginOnLoadState(),
    );
  }

  FutureOr<void> _onPasswordVisible(
      LoginPasswordVisibleEvent event, Emitter<LoginState> emit) {
    final castState = state as LoginOnLoadState;

    emit(
      castState.copyWith(
        isPasswordObscured: !castState.isPasswordObscured,
        errorMessage: '',
      ),
    );
  }

  FutureOr<void> _onLoginDetailsUpdate(
      LoginDetailsUpdateEvent event, Emitter<LoginState> emit) {
    final castState = state as LoginOnLoadState;
    emit(
      castState.copyWith(
        email: event.email ?? castState.email,
        password: event.password ?? castState.password,
        errorMessage: '',
      ),
    );
  }

  FutureOr<void> _onLoginSubmit(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    final castState = state as LoginOnLoadState;

    emit(
      castState.copyWith(
        errorMessage: '',
      ),
    );

    var errorMessage = '';
    if (castState.email.isEmpty) {
      errorMessage = 'Please enter email address';
    }
    /*else if (castState.email.isNotEmpty &&
        CommonValidation.isValidEmailId(castState.email) != null) {
      errorMessage = 'Invalid email address';
    }*/
    else if (castState.password.isEmpty) {
      errorMessage = 'Please enter password';
    }

    if (errorMessage.isNotEmpty) {
      emit(
        castState.copyWith(
          errorMessage: errorMessage,
        ),
      );
    } else {
      // show circular progress indicator
      emit(
        castState.copyWith(
          isLoginLoading: true,
          errorMessage: '',
        ),
      );

      final loginRequestModel = LoginRequestModel(
        name: castState.email,
        password: castState.password,
      );

      final loginResponse = await _loginRepo.loginRequest(
        loginRequestModel: loginRequestModel,
      );
      if (loginResponse != null && (loginResponse.userId ?? '').isNotEmpty) {
        // save user id into shared preferences
        await _authRepo.saveProfile(loginResponse.userId ?? '');
        // complete login
        await _authRepo.completeLogin();

        // Login api call
        emit(
          LoginSuccessState(
            message: 'Logged in successfully',
          ),
        );
      } else {
        emit(
          castState.copyWith(
            isLoginLoading: false,
            errorMessage: loginResponse?.error,
          ),
        );
      }
    }
  }
}
