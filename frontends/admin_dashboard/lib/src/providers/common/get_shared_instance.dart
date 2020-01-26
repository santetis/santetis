import 'package:admin_dashboard/src/rpcs/shared_preferences/get_instance.dart';
import 'package:provider/provider.dart';

final getSharedInstance = Provider<GetSharedInstanceRpc>(
  create: (context) => GetSharedInstanceRpc(),
);
