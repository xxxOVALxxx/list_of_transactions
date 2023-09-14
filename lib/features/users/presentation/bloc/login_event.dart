part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class Auth extends LoginEvent {
  Auth(this.email, this.password);
  final String email;
  final String password;
}
