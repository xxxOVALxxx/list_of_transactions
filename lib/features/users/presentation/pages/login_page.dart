import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:list_of_transactions/app/theme.dart';
import 'package:list_of_transactions/features/users/presentation/bloc/login_bloc.dart';
import 'package:list_of_transactions/features/users/presentation/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  context.go('/home');
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: spaceMd),
                  child: Column(
                    children: [
                      if (state is IncorrectCredentials)
                        const IncorrectCredentialsMessage(),
                      Padding(
                        padding: const EdgeInsets.only(top: spaceSm),
                        child: TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          validator: _emailValidator,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: spaceSm, bottom: spaceSm),
                        child: TextFormField(
                          focusNode: _focusNodePassword,
                          controller: _controllerPassword,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: _passwordValidator,
                        ),
                      ),
                      if (state is Authentication)
                        const CircularProgressIndicator()
                      else
                        OutlinedButton(
                          onPressed: () =>
                              _onLoginButtonPressed(context.read<LoginBloc>()),
                          child: const Text(
                            'Login',
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter username.";
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter password.";
    }

    return null;
  }

  void _onLoginButtonPressed(LoginBloc loginBloc) {
    bool? isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid == false) {
      return;
    }
    loginBloc.add(Auth(_controllerEmail.text, _controllerPassword.text));
  }
}
