import 'package:admin_dashboard/src/rpcs/users/sign_in.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

final signInRpc = ProxyProvider<Dio, SignInRpc>(
  update: (context, dio, previousValue) {
    return previousValue ?? SignInRpc(dio);
  },
);
