import 'dart:async';

import 'package:flutter/material.dart';
import 'package:list_of_transactions/features/users/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_transactions/features/users/domain/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.repository) : super(NotAuthenticated()) {
    on<Auth>(_onAuth);
  }

  final UserRepository repository;

  FutureOr<void> _onAuth(Auth event, Emitter<LoginState> emit) async {
    emit(Authentication());

    User? fetchedUser = await repository.fetchUser(event.email);
    if (fetchedUser == null) {
      emit(IncorrectCredentials());
      return;
    }

    if (fetchedUser.password == event.password) {
      emit(Authenticated(fetchedUser));
    } else {
      emit(IncorrectCredentials());
    }
    return null;
  }
}
