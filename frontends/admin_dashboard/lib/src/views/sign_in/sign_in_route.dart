import 'package:admin_dashboard/src/views/sign_in/sign_in_view.dart';
import 'package:admin_dashboard/src/widgets/initialization.dart';
import 'package:flutter/widgets.dart';
import 'package:san_router/san_router.dart';

class SignInRoute extends SanRoute {
  SignInRoute() : super(path: 'sign_in');

  @override
  Widget build(BuildContext context) {
    return Initialization(
      child: SignIn(),
    );
  }
}
