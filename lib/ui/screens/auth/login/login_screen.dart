import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/login_bloc/login_bloc.dart';
import '../../../../repositories/user_repo.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  final String? message;

  // ignore: use_key_in_widget_constructors
  const LoginScreen(
      {required UserRepository userRepository, required this.message})
      : _userRepository = userRepository,
        super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: _userRepository),
      child: LoginForm(
        userRepository: _userRepository,
        message: message,
      ),
    );
  }
}
