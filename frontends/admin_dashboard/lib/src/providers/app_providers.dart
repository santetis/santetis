import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  final List<SingleChildWidget> providers;

  const AppProviders({Key key, @required this.child, this.providers = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}
