part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpOnLoadEvent extends SignUpEvent {
  const SignUpOnLoadEvent();
}

class SignUpPasswordVisibleEvent extends SignUpEvent {
  const SignUpPasswordVisibleEvent();
}

class SignUpConfirmPasswordVisibleEvent extends SignUpEvent {
  const SignUpConfirmPasswordVisibleEvent();
}

class SignUpDetailsUpdateEvent extends SignUpEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  const SignUpDetailsUpdateEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        confirmPassword,
      ];
}

class CreateNewAccountEvent extends SignUpEvent {}
