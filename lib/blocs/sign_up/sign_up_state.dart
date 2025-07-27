part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

final class SingUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpOnLoadState extends SignUpState {
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSignUpInProgress;
  final String? errorMessage;
  const SignUpOnLoadState({
    this.isPasswordObscured = true,
    this.isConfirmPasswordObscured = true,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isSignUpInProgress = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        isPasswordObscured,
        isConfirmPasswordObscured,
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
        isSignUpInProgress,
        errorMessage,
      ];

  SignUpOnLoadState copyWith({
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSignUpInProgress,
    String? errorMessage,
  }) {
    return SignUpOnLoadState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSignUpInProgress: isSignUpInProgress ?? this.isSignUpInProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class SignUpSuccessState extends SignUpState {}
