import 'package:admin_dashboard/src/providers/common/app_state.dart';
import 'package:admin_dashboard/src/providers/common/dio.dart';
import 'package:admin_dashboard/src/providers/common/get_shared_instance.dart';
import 'package:admin_dashboard/src/providers/common/users/sign_in.dart';
import 'package:provider/single_child_widget.dart';

final commonProviders = <SingleChildWidget>[
  dio,
  getSharedInstance,
  signInRpc,
  appState,
];
