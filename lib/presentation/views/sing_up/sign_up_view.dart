import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:to_do_app/core/utils/ui_extension.dart';
import 'package:to_do_app/presentation/widgets/loading_widget.dart';
import 'package:to_do_app/presentation/widgets/sign_up/sign_up_widget.dart';
import 'package:to_do_app/routes/routes.dart';

class SignUpView extends StatelessWidget {
  static const keyPrefix = 'SignUpView';

  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state is SignUpOnLoadState &&
            (state.errorMessage ?? '').isNotEmpty) {
          UiExtension.showToastError(
            message: state.errorMessage ?? '',
          );
        }

        if (state is SignUpSuccessState) {
          UiExtension.showToastSuccess(
            message: 'User registered successfully',
          );
          context.goNamed(Routes.login.name);
        }
      },
      builder: (context, state) {
        if (state is SignUpOnLoadState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SignUpWidget(
                firstName: state.firstName,
                lastName: state.lastName,
                email: state.email,
                password: state.password,
                confirmPassword: state.confirmPassword,
                isPasswordObscured: state.isPasswordObscured,
                isConfirmPasswordObscured: state.isConfirmPasswordObscured,
                isSignUpInProgress: state.isSignUpInProgress,
              ),
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
