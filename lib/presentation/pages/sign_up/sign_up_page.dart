import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:to_do_app/presentation/views/sing_up/sign_up_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc()
        ..add(
          const SignUpOnLoadEvent(),
        ),
      child: const SignUpView(),
    );
  }
}
