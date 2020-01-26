import 'package:admin_dashboard/src/views/dashboard/dashboard_view.dart';
import 'package:admin_dashboard/src/widgets/initialization.dart';
import 'package:flutter/widgets.dart';
import 'package:san_router/san_router.dart';

class DashboardRoute extends SanRoute {
  DashboardRoute() : super(path: 'dashboard');

  @override
  Widget build(BuildContext context) {
    return Initialization(
      child: Dashboard(),
    );
  }
}
