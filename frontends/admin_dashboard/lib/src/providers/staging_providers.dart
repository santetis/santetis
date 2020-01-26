import 'package:admin_dashboard/src/providers/common.dart';
import 'package:admin_dashboard/src/providers/common/base_url.dart';
import 'package:provider/single_child_widget.dart';

final stagingProviders = <SingleChildWidget>[
  baseUrl(
      'https://santetisfmaxsfvo-stagingapi.functions.fnc.fr-par.scw.cloud/'),
  ...commonProviders,
];
