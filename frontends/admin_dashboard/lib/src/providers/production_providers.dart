import 'package:admin_dashboard/src/providers/common.dart';
import 'package:admin_dashboard/src/providers/common/base_url.dart';
import 'package:provider/single_child_widget.dart';

final productionProviders = <SingleChildWidget>[
  baseUrl(
      'https://santetisfmaxsfvo-productionapi.functions.fnc.fr-par.scw.cloud/'),
  ...commonProviders,
];
