import 'package:admin_dashboard/src/state/app.dart';
import 'package:admin_dashboard/src/views/splashscreen/splashcreen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Initialization extends StatelessWidget {
  final Widget child;

  const Initialization({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final appState = Provider.of<AppState>(context, listen: false);
        if (!appState.isAppInitialized) {
          return Splashscreen();
        }
        return child;
      },
    );
  }
}
