import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:san_router/san_router.dart';

class ExampleRoute extends SanRoute {
  final Widget child;

  ExampleRoute({@required String path, this.child}) : super(path: path);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
