import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/login/login_bloc.dart';
import 'package:to_do_app/core/consts/asset_images.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/presentation/widgets/components/single_line_input_content.dart';
import 'package:to_do_app/routes/routes.dart';

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
      body: SingleChildScrollView(
        child: Stack(
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
                    height: MediaQuery.of(context).size.height * .7,
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
                          'Welcome Back',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: SingleLineInputContent(
                            key: const ValueKey('$keyPrefix-Email'),
                            textInputAction: TextInputAction.next,
                            title: '',
                            hintText: 'Enter Email',
                            userResponse: email,
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
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: SingleLineInputContent(
                            key: const ValueKey('$keyPrefix-password'),
                            textInputAction: TextInputAction.next,
                            title: '',
                            hintText: 'Password',
                            obscureText: true,
                            userResponse: password,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .8,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  const LoginSubmitEvent(),
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
                              child: isLoginLoading
                                  ? SizedBox(
                                      height: 23.0,
                                      width: 23.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Log In',
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'or Continue with Google?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            'Dont have an Account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: InkWell(
                            onTap: () {
                              context.pushNamed(Routes.signUp.name);
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
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
              top: MediaQuery.of(context).size.height * .21,
              left: MediaQuery.of(context).size.width * .31,
              child: Image.asset(
                AssetPNGImages.loginImage,
                height: 157.0,
                width: 157.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
