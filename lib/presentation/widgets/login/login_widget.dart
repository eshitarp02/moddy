import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/palette.dart';
import 'package:to_do_app/presentation/widgets/login/login_form_widget.dart';

class LoginWidget extends StatelessWidget {
  static const keyPrefix = 'LoginWidget';
  final String email;
  final String password;
  final bool isPasswordObscured;
  final bool isLoginLoading;
  const LoginWidget({
    super.key,
    required this.email,
    required this.password,
    required this.isPasswordObscured,
    required this.isLoginLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('${LoginWidget.keyPrefix}-loginPage'),
      body: _loginPortraitWidget(context: context),
    );
  }

  Widget _loginPortraitWidget({required BuildContext context}) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: Palette.primaryBlue,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height * .60,
              width: MediaQuery.of(context).size.width * .75,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Palette.borderColor),
              ),
              child: _loginFormWidget(context: context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginFormWidget({required BuildContext context}) {
    return LoginFormWidget(
      email: email,
      isPasswordObscured: isPasswordObscured,
      password: password,
      isLoginLoading: isLoginLoading,
    );
  }
}
