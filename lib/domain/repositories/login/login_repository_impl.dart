import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/data/api/login/login_api.dart';
import 'package:to_do_app/domain/model/request/login_request_model.dart';
import 'package:to_do_app/domain/model/response/login_response_model.dart';
import 'package:to_do_app/domain/repositories/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final loginApi = GetIt.I<LoginApi>();

  @override
  Future<LoginResponseModel?> loginRequest({
    required LoginRequestModel loginRequestModel,
  }) {
    return loginApi.loginRequest(loginRequestModel: loginRequestModel,);
  }
}
