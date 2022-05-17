import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/SuccessModel.dart';

import 'dart:async';

class ChuckRepository {
  ApiProvider _provider = ApiProvider();

  Future<SuccessModel> getuserCount() async {
    final response = await _provider.post("/account/get-totalusers-count",{});
    return SuccessModel.fromJson(response);
  }

  Future<SuccessModel> doctorAccountLogin(dynamic _loginData) async {
    final response = await _provider.post("/account/doctor-login",_loginData);
    return SuccessModel.fromJson(response);
  }
}