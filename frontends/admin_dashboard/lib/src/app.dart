import 'package:admin_dashboard/src/state/app.dart';
import 'package:admin_dashboard/src/themes/theme_data.dart';
import 'package:admin_dashboard/src/views/dashboard/dashboard_route.dart';
import 'package:admin_dashboard/src/views/sign_in/sign_in_route.dart';
import 'package:admin_dashboard/src/views/splashscreen/splashcreen_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:san_router/san_router.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final _routes = SanRoutes(
    routes: [
      SignInRoute(),
      DashboardRoute(),
    ],
  );

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    when((_) => appState.isAppInitialized, () {
      if (appState.user == null &&
          ['dashboard', '/dashboard', '/'].contains(appState.currentPath)) {
        navigatorKey.currentState.pushReplacementNamed('sign_in');
      } else if (appState.user != null &&
          ['sign_in', '/sign_in'].contains(appState.currentPath)) {
        navigatorKey.currentState.pushReplacementNamed('dashboard');
      }
    });
    appState.init();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      home: Splashscreen(),
      onGenerateRoute: _routes.onGeneratedRoute,
      navigatorObservers: [
        AppStateUpdaterObserver(appState),
      ],
    );
  }
}

class AppStateUpdaterObserver extends NavigatorObserver {
  final AppState _appState;

  AppStateUpdaterObserver(this._appState);

  @override
  void didPush(Route route, Route previousRoute) {
    _appState.oldPath = _appState.currentPath;
    _appState.currentPath = route.settings.name;
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _appState.oldPath = _appState.currentPath;
    _appState.currentPath = route.settings.name;
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    _appState.oldPath = _appState.currentPath;
    _appState.currentPath = route.settings.name;
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    _appState.oldPath = _appState.currentPath;
    _appState.currentPath = newRoute.settings.name;
  }
}
