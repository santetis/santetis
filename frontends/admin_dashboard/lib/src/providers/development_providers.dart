import 'package:admin_dashboard/src/providers/common.dart';
import 'package:admin_dashboard/src/providers/common/base_url.dart';
import 'package:provider/single_child_widget.dart';

final developmentProviders = <SingleChildWidget>[
  baseUrl('http://192.168.1.40:8080/'),
  ...commonProviders,
];
