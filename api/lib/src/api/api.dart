import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'api.g.dart';

class Api {
  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  Router get router => _$ApiRouter(this);
}
