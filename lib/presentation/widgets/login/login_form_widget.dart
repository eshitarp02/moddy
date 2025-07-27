import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/login/login_bloc.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/core/utils/palette.dart';
import 'package:to_do_app/presentation/widgets/components/single_line_input_content.dart';
import 'package:to_do_app/routes/routes.dart' show Routes;

class LoginFormWidget extends StatelessWidget {
  static const keyPrefix = 'LoginFormWidget';
  const LoginFormWidget({
    super.key,
    required this.email,
    required this.isPasswordObscured,
    required this.password,
    required this.isLoginLoading,
  });

  final String email;
  final bool isPasswordObscured;
  final String password;
  final bool isLoginLoading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 10,
          right: MediaQuery.of(context).size.width / 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Palette.lightModePrimaryTextColor,
                  ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Hello, welcome back',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SingleLineInputContent(
              key: const ValueKey('$keyPrefix-Email'),
              textInputAction: TextInputAction.next,
              title: Strings.emailView,
              userResponse: email,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer, // Color(0xff6b6b6b)
              ),
              editTextType: Strings.email,
              onChanged: (String value) {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginDetailsUpdateEvent(
                    email: value,
                  ),
                );
              },
              onSubmitted: (String value) {},
            ),
            const SizedBox(
              height: 16.0,
            ),
            SingleLineInputContent(
              key: const ValueKey('$keyPrefix-Password'),
              obscureText: isPasswordObscured,
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(
                    const LoginPasswordVisibleEvent(),
                  );
                },
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              textInputAction: TextInputAction.done,
              title: Strings.passwordsView,
              userResponse: password,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              editTextType: Strings.password,
              onChanged: (String value) {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginDetailsUpdateEvent(
                    password: value,
                  ),
                );
              },
              onSubmitted: (String value) {},
            ),
            const SizedBox(
              height: 32.0,
            ),
            SizedBox(
              width: double.infinity,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      const LoginSubmitEvent(),
                    );
                  },
                  label: isLoginLoading
                      ? const SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(Strings.login),
                  icon: !isLoginLoading ? const Icon(Icons.arrow_back) : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0), // <-- Radius
                    ),
                    padding: const EdgeInsets.all(20.0),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Palette.lightModePrimaryTextColor,
                    ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.pushNamed(Routes.signUp.name),
                    text: 'Sign Up',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Palette.primaryBlue,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
