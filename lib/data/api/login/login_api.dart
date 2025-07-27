import 'dart:async';

import 'package:to_do_app/domain/model/request/login_request_model.dart';
import 'package:to_do_app/domain/model/response/login_response_model.dart';

abstract class LoginApi {
  Future<LoginResponseModel?> loginRequest({
    required LoginRequestModel loginRequestModel,
  });
}
