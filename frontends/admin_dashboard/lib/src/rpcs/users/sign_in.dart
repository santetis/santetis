import 'dart:convert';
import 'dart:html';

import 'package:admin_dashboard/src/rpcs/base.dart';
import 'package:dio/dio.dart';
import 'package:network_entities/network_entities.dart';

class SignInRpc extends Rpc<SignInRequestData, SignInResponseData> {
  final Dio _dio;

  SignInRpc(this._dio);

  @override
  Future<SignInResponseData> request(SignInRequestData input) async {
    try {
      final response = await _dio.post('/users/sign_in', data: input);
      return SignInResponseData.fromJson(json.decode(response.data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE &&
          e.response.statusCode == HttpStatus.notFound) {
        throw 'Email or password are not correct';
      }
    }
    throw 'unknown error';
  }
}
