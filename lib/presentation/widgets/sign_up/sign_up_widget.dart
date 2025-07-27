import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/core/utils/palette.dart';
import 'package:to_do_app/presentation/widgets/components/single_line_input_content.dart';
import 'package:to_do_app/routes/routes.dart';

class SignUpWidget extends StatelessWidget {
  static const keyPrefix = 'SignUpView';
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final bool isSignUpInProgress;
  const SignUpWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
    required this.isSignUpInProgress,
  });

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
              'Sign Up',
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
              'Just a few quick things to get started',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SingleLineInputContent(
              key: const ValueKey('$keyPrefix-FirstName'),
              textInputAction: TextInputAction.next,
              title: Strings.firstName,
              userResponse: firstName,
              prefixIcon: Icon(
                Icons.person_outline,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer, // Color(0xff6b6b6b)
              ),
              editTextType: Strings.firstName,
              onChanged: (String value) {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpDetailsUpdateEvent(
                    firstName: value,
                  ),
                );
              },
              onSubmitted: (String value) {},
            ),
            const SizedBox(
              height: 16.0,
            ),
            SingleLineInputContent(
              key: const ValueKey('$keyPrefix-LastName'),
              textInputAction: TextInputAction.next,
              title: Strings.lastName,
              userResponse: lastName,
              prefixIcon: Icon(
                Icons.person_outline,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer, // Color(0xff6b6b6b)
              ),
              editTextType: Strings.lastName,
              onChanged: (String value) {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpDetailsUpdateEvent(
                    lastName: value,
                  ),
                );
              },
              onSubmitted: (String value) {},
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
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpDetailsUpdateEvent(
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
                  BlocProvider.of<SignUpBloc>(context).add(
                    const SignUpPasswordVisibleEvent(),
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
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpDetailsUpdateEvent(
                    password: value,
                  ),
                );
              },
              onSubmitted: (String value) {},
            ),
            const SizedBox(
              height: 16.0,
            ),
            SingleLineInputContent(
              key: const ValueKey('$keyPrefix-Confirm-Password'),
              obscureText: isConfirmPasswordObscured,
              suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<SignUpBloc>(context).add(
                    const SignUpConfirmPasswordVisibleEvent(),
                  );
                },
                icon: Icon(
                  isConfirmPasswordObscured
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              textInputAction: TextInputAction.done,
              title: Strings.confirmPasswordsView,
              userResponse: confirmPassword,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              editTextType: Strings.password,
              onChanged: (String value) {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUpDetailsUpdateEvent(
                    confirmPassword: value,
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
                    BlocProvider.of<SignUpBloc>(context).add(
                      CreateNewAccountEvent(),
                    );
                  },
                  label: isSignUpInProgress
                      ? const SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(Strings.createAccount),
                  icon:
                      !isSignUpInProgress ? const Icon(Icons.arrow_back) : null,
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
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Palette.lightModePrimaryTextColor,
                    ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.goNamed(Routes.login.name),
                    text: 'Login In',
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
