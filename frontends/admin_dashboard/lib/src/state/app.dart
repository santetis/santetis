import 'dart:io';

import 'package:admin_dashboard/src/rpcs/shared_preferences/get_instance.dart';
import 'package:admin_dashboard/src/rpcs/users/sign_in.dart';
import 'package:admin_dashboard/src/state/user.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:network_entities/network_entities.dart';

part 'app.g.dart';

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  final Dio _dio;
  final GetSharedInstanceRpc _getSharedInstance;
  final SignInRpc _signInRpc;

  @observable
  bool isAppInitialized = false;

  @observable
  UserState user;

  String currentPath;
  String oldPath;

  AppStateBase(this._dio, this._getSharedInstance, this._signInRpc);

  @action
  Future<void> init() async {
    await _getSharedInstance.request(null);
    isAppInitialized = true;
  }

  Future<void> signIn(SignInRequestData data) async {
    final response = await _signInRpc.request(data);
    _dio.options = BaseOptions(
      baseUrl: _dio.options.baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: response.token,
      },
    );
    //  todo: get user informations
  }
}
