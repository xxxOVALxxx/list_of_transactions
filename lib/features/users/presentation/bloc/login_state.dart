part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class NotAuthenticated extends LoginState {}

final class Authenticated extends LoginState {
  Authenticated(this.user);

  final User user;
}

final class Authentication extends LoginState {}

final class IncorrectCredentials extends LoginState {}
