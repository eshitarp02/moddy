import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/api/signup/sign_up_api.dart';
import 'package:to_do_app/domain/model/request/signup_request_model.dart';
import 'package:to_do_app/domain/model/response/signup_response_model.dart';
import 'package:to_do_app/domain/repositories/signup/signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository {
  final signUpApi = GetIt.I<SignUpApi>();

  @override
  Future<SignUpResponseModel?> registerUser({
    required SignUpRequestModel signUpRequestModel,
  }) {
    return signUpApi.registerUser(
      signUpRequestModel: signUpRequestModel,
    );
  }
}
