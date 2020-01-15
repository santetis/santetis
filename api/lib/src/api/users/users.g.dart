// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UsersRouter(Users service) {
  final router = Router();
  router.add('POST', r'/', service.createUser);
  router.add('POST', r'/sign_in', service.signIn);
  return router;
}
