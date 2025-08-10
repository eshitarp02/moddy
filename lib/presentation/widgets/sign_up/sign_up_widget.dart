import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/sign_up/sign_up_bloc.dart';
import 'package:to_do_app/core/consts/asset_images.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/presentation/widgets/components/single_line_input_content.dart';
import 'package:to_do_app/routes/routes.dart';

class SignUpWidget extends StatelessWidget {
  static const keyPrefix = 'SignUpWidget';
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
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AssetPNGImages.appBackGround,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(
                  top: 100.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0XFFD5B4EA),
                      Color(0XFFC5A7D9),
                      Color(0XFF6360C5),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(53.0),
                    topRight: Radius.circular(53.0),
                  ), // Optional: for rounded corners
                ),
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Just a few quick things to get started',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .7,
                        child: SingleLineInputContent(
                          key: const ValueKey('$keyPrefix-FirstName'),
                          textInputAction: TextInputAction.next,
                          title: '',
                          userResponse: firstName,
                          hintText: 'Enter First Name',
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
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: SingleLineInputContent(
                        key: const ValueKey('$keyPrefix-LastName'),
                        textInputAction: TextInputAction.next,
                        title: '',
                        userResponse: lastName,
                        hintText: 'Enter Last Name',
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: SingleLineInputContent(
                        key: const ValueKey('$keyPrefix-Email'),
                        textInputAction: TextInputAction.next,
                        title: '',
                        userResponse: email,
                        hintText: 'Enter Email',
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: SingleLineInputContent(
                        key: const ValueKey('$keyPrefix-Password'),
                        obscureText: isPasswordObscured,
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<SignUpBloc>(context).add(
                              const SignUpPasswordVisibleEvent(),
                            );
                          },
                          icon: Icon(
                            isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        title: '',
                        userResponse: password,
                        hintText: 'Enter Password',
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
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: SingleLineInputContent(
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
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        title: '',
                        userResponse: confirmPassword,
                        hintText: 'Confirm Password',
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<SignUpBloc>(context).add(
                              CreateNewAccountEvent(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF534FCF),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: isSignUpInProgress
                              ? SizedBox(
                                  height: 23.0,
                                  width: 23.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  Strings.createAccount,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => context.goNamed(Routes.login.name),
                              text: 'Log In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .11,
          left: MediaQuery.of(context).size.width * .31,
          child: Image.asset(
            AssetPNGImages.loginImage,
            height: 157.0,
            width: 157.0,
          ),
        )
      ],
    );
  }
}
