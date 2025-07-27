part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitialState extends LoginState {}

final class LoginOnLoadState extends LoginState {
  final bool isPasswordObscured;
  final String email;
  final String password;
  final bool isLoginLoading;
  final String? errorMessage;

  const LoginOnLoadState({
    this.isPasswordObscured = true,
    this.email = '',
    this.password = '',
    this.isLoginLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        isPasswordObscured,
        isLoginLoading,
        errorMessage,
      ];

  LoginOnLoadState copyWith({
    bool? isPasswordObscured,
    String? email,
    String? password,
    bool? isLoginLoading,
    String? errorMessage,
  }) {
    return LoginOnLoadState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final class LoginSuccessState extends LoginState {
  final String message;

  const LoginSuccessState({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
