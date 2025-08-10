import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/utils/validation.dart';
import 'package:to_do_app/domain/model/request/signup_request_model.dart';
import 'package:to_do_app/domain/repositories/signup/signup_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final _signUpRepo = GetIt.I<SignupRepository>();

  SignUpBloc() : super(SingUpInitial()) {
    on<SignUpOnLoadEvent>(_onLoadSignUp);
    on<SignUpPasswordVisibleEvent>(_onPasswordVisible);
    on<SignUpConfirmPasswordVisibleEvent>(_onConfirmPasswordVisible);
    on<SignUpDetailsUpdateEvent>(_onSignUpDetailsUpdate);
    on<CreateNewAccountEvent>(_onCreateNewAccount);
  }

  FutureOr<void> _onLoadSignUp(
      SignUpOnLoadEvent event, Emitter<SignUpState> emit) async {
    emit(
      SignUpOnLoadState(),
    );
  }

  FutureOr<void> _onPasswordVisible(
      SignUpPasswordVisibleEvent event, Emitter<SignUpState> emit) {
    final castState = state as SignUpOnLoadState;

    emit(
      castState.copyWith(
        isPasswordObscured: !castState.isPasswordObscured,
      ),
    );
  }

  FutureOr<void> _onConfirmPasswordVisible(
      SignUpConfirmPasswordVisibleEvent event, Emitter<SignUpState> emit) {
    final castState = state as SignUpOnLoadState;

    emit(
      castState.copyWith(
        isConfirmPasswordObscured: !castState.isConfirmPasswordObscured,
      ),
    );
  }

  FutureOr<void> _onSignUpDetailsUpdate(
      SignUpDetailsUpdateEvent event, Emitter<SignUpState> emit) {
    final castState = state as SignUpOnLoadState;

    emit(
      castState.copyWith(
        firstName: event.firstName ?? castState.firstName,
        lastName: event.lastName ?? castState.lastName,
        email: event.email ?? castState.email,
        password: event.password ?? castState.password,
        confirmPassword: event.confirmPassword ?? castState.confirmPassword,
        errorMessage: '',
      ),
    );
  }

  FutureOr<void> _onCreateNewAccount(
      CreateNewAccountEvent event, Emitter<SignUpState> emit) async {
    final castState = state as SignUpOnLoadState;

    emit(
      castState.copyWith(
        errorMessage: '',
        isSignUpInProgress: true,
      ),
    );

    var errorMessage = '';
    final isValidEmailId = CommonValidation.isValidEmailId(
      castState.email,
    );

    if (castState.firstName.isEmpty) {
      errorMessage = 'Please enter first name';
    } else if (castState.lastName.isEmpty) {
      errorMessage = 'Please enter last name';
    } else if (isValidEmailId != null) {
      errorMessage = 'Invalid Email address';
    } else if (castState.password.length < 8) {
      errorMessage = 'Password should be of minimum 8 char';
    } else if (castState.confirmPassword.length < 8) {
      errorMessage = 'Confirm Password should be of minimum 8 char';
    } else if (castState.password != castState.confirmPassword) {
      errorMessage = 'Both password should be same';
    }

    if (errorMessage.isNotEmpty) {
      emit(
        castState.copyWith(
          errorMessage: errorMessage,
          isSignUpInProgress: false,
        ),
      );
    } else {
      final signUpRequestModel = SignUpRequestModel(
        action: 'register',
        name: '${castState.firstName} ${castState.lastName}',
        email: castState.email,
        password: castState.password,
        provider: 'email',
      );

      final signUpResponse = await _signUpRepo.registerUser(
        signUpRequestModel: signUpRequestModel,
      );
      if (signUpResponse != null && (signUpResponse.userId ?? '').isNotEmpty) {
        emit(
          SignUpSuccessState(),
        );
      } else {
        emit(
          castState.copyWith(
            errorMessage: 'Something went wrong...',
          ),
        );
      }
    }
  }
}
