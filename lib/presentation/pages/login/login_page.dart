import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/login/login_bloc.dart';
import 'package:to_do_app/presentation/views/login/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc()
        ..add(
          const LoginOnLoadEvent(),
        ),
      child: const LoginView(),
    );
  }
}
