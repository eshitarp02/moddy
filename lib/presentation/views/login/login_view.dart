import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/login/login_bloc.dart';
import 'package:to_do_app/core/utils/ui_extension.dart';
import 'package:to_do_app/presentation/widgets/loading_widget.dart';
import 'package:to_do_app/presentation/widgets/login/login_widget.dart';
import 'package:to_do_app/routes/routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          UiExtension.showToastSuccess(
            message: state.message,
          );
          context.goNamed(Routes.home.name);
        }
        if (state is LoginOnLoadState &&
            (state.errorMessage ?? '').isNotEmpty) {
          UiExtension.showToastError(
            message: state.errorMessage ?? '',
          );
        }
      },
      builder: (context, state) {
        if (state is LoginOnLoadState) {
          return LoginWidget(
            email: state.email,
            password: state.password,
            isPasswordObscured: state.isPasswordObscured,
            isLoginLoading: state.isLoginLoading,
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
