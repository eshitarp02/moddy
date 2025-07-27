part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginOnLoadEvent extends LoginEvent {
  const LoginOnLoadEvent();
}

class LoginPasswordVisibleEvent extends LoginEvent {
  const LoginPasswordVisibleEvent();
}

class LoginDetailsUpdateEvent extends LoginEvent {
  final String? email;
  final String? password;
  const LoginDetailsUpdateEvent({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginSubmitEvent extends LoginEvent {
  final String? email;
  final String? password;
  const LoginSubmitEvent({
    this.email,
    this.password,
  });
  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
