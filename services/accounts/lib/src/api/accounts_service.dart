import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'accounts_service.g.dart';

class AccountsService {
  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  Router get router => _$AccountsServiceRouter(this);
}
