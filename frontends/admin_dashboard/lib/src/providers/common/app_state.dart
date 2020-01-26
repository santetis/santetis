import 'package:admin_dashboard/src/rpcs/shared_preferences/get_instance.dart';
import 'package:admin_dashboard/src/rpcs/users/sign_in.dart';
import 'package:admin_dashboard/src/state/app.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final appState = ProxyProvider3<Dio, GetSharedInstanceRpc, SignInRpc, AppState>(
  update: (context, dio, getSharedInstance, signIn, previousValue) {
    return previousValue ?? AppState(dio, getSharedInstance, signIn);
  },
);
