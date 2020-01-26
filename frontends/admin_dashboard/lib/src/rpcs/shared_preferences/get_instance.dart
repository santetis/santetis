import 'dart:async';

import 'package:admin_dashboard/src/rpcs/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSharedInstanceRpc extends Rpc<void, SharedPreferences> {
  @override
  Future<SharedPreferences> request(void input) =>
      SharedPreferences.getInstance();
}
