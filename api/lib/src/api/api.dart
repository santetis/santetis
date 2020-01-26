import 'package:api/src/api/users/users.dart';
import 'package:api/src/middlewares/cors.dart';
import 'package:api/src/rpcs/tokens/save_token.dart';
import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:api/src/rpcs/users/get_user_with_email_and_password.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'api.g.dart';

class Api {
  final GetUserByEmailRpc getUserByEmailRpc;
  final CreateUserRpc createUserRpc;
  final GetUserWithEmailAndPasswordRpc getUserWithEmailAndPasswordRpc;
  final SaveTokenRpc saveTokenRpc;

  Api({
    @required this.getUserByEmailRpc,
    @required this.createUserRpc,
    @required this.getUserWithEmailAndPasswordRpc,
    @required this.saveTokenRpc,
  });

  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  @Route.mount('/users/')
  Router get _users => Users(
        createUserRpc: createUserRpc,
        getUserByEmailRpc: getUserByEmailRpc,
        getUserWithEmailAndPasswordRpc: getUserWithEmailAndPasswordRpc,
        saveTokenRpc: saveTokenRpc,
      ).router;

  Handler get handler => Pipeline()
      .addMiddleware(createCorsHeadersMiddleware())
      .addHandler(_$ApiRouter(this).handler);
}
