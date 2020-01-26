import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:san_router_example/src/views/welcome.dart';
import 'package:san_router/san_router.dart';

class HomeRoute extends SanRoute {
  static String routePath = '/';

  HomeRoute() : super(path: HomeRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final name = 'anonymous';
    return Provider<String>.value(
      value: name,
      child: WelcomePage(),
    );
  }
}

class GrettingsRoute extends SanRoute {
  static String routePath = '/greetings/:name';

  static String generateRoute(String name) {
    return SanRoute.generateRoute(routePath, pathParams: {'name': name});
  }

  GrettingsRoute() : super(path: GrettingsRoute.routePath);

  @override
  Widget build(BuildContext context) {
    final routeParams = Provider.of<SanRouteParameters>(context);
    final name = routeParams.pathParameters['name'] ?? 'anonymous';
    return Provider<String>.value(
      value: name,
      child: WelcomePage(),
    );
  }

  @override
  Route routeBuilder(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (c) => handle(context: c, routeSettings: routeSettings),
      settings: routeSettings,
    );
  }
}
