import 'dart:async';

import 'package:to_do_app/domain/model/request/signup_request_model.dart';
import 'package:to_do_app/domain/model/response/signup_response_model.dart';

abstract class SignUpApi {
  Future<SignUpResponseModel?> registerUser({
    required SignUpRequestModel signUpRequestModel,
  });
}
