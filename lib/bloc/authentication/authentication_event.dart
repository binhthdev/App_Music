import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  const RegisterRequested(this.email, this.password, this.username);
}
class LogoutRequested extends AuthenticationEvent {}