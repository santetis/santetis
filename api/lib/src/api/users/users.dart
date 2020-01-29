import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:api/src/models/token.dart';
import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/tokens/save_token.dart';
import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:api/src/rpcs/users/get_user_from_token.dart';
import 'package:api/src/rpcs/users/get_user_with_email_and_password.dart';
import 'package:api/src/utils/checks/check_body_not_empty.dart';
import 'package:api/src/utils/checks/check_is_admin_user.dart';
import 'package:api/src/utils/checks/check_request_has_token.dart';
import 'package:api/src/utils/checks/check_token_exist.dart';
import 'package:api/src/utils/checks/check_user_already_exist.dart';
import 'package:api/src/utils/checks/check_user_exist.dart';
import 'package:api/src/utils/error_response.dart';
import 'package:api/src/utils/get/get_user.dart';
import 'package:crypto/crypto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:network_entities/network_entities.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'users.g.dart';

class Users {
  final GetUserByEmailRpc getUserByEmailRpc;
  final CreateUserRpc createUserRpc;
  final GetUserWithEmailAndPasswordRpc getUserWithEmailAndPasswordRpc;
  final SaveTokenRpc saveTokenRpc;
  final GetTokenRpc getTokenRpc;
  final GetUserWithTokenRpc getUserWithTokenRpc;

  Users({
    @required this.getUserByEmailRpc,
    @required this.createUserRpc,
    @required this.getUserWithEmailAndPasswordRpc,
    @required this.saveTokenRpc,
    @required this.getTokenRpc,
    @required this.getUserWithTokenRpc,
  });

  @Route.post('/')
  Future<Response> createUser(Request request) async {
    try {
      final user = await getUserFromRequest(
        request,
        getTokenRpc,
        getUserWithTokenRpc,
      );
      checkIsAdminUser(user);
      final body = await request.readAsString();
      checkBodyIsEmpty(body);
      final data = CreateUserRequestData.fromJson(json.decode(body));
      final _user = await getUserByEmailRpc.request(data.email);
      checkUserAlreadyExist(_user);
      await createUserRpc.request(
        DatabaseUser(data.email, data.accountType, DateTime.now().toUtc(),
            password: sha512.convert(data.password.codeUnits).toString()),
      );
      return Response(HttpStatus.created);
    } on NoAuthorizationHeaderError catch (_) {
      return errorResponse(
          HttpStatus.badRequest, 'AUTHORIZATION_HEADER_NEEDED');
    } on NoTokenFoundError catch (_) {
      return errorResponse(HttpStatus.unauthorized, 'UNAUTHORIZED');
    } on UserNotFoundError catch (_) {
      return errorResponse(HttpStatus.notFound, 'USER_NOT_FOUND');
    } on NotAnAdminUserError catch (_) {
      return errorResponse(HttpStatus.unauthorized, 'NOT_AN_ADMIN');
    } on UserAlreadyExistError catch (_) {
      return errorResponse(HttpStatus.conflict, 'USER_ALREADY_EXIST');
    } on MissingRequiredKeysException catch (e) {
      return errorResponse(HttpStatus.badRequest, 'BAD_ARGUMENTS',
          value: e.missingKeys);
    } on BodyIsEmptyError catch (_) {
      return errorResponse(HttpStatus.badRequest, 'BAD_ARGUMENTS');
    } on FormatException catch (e) {
      return errorResponse(HttpStatus.badRequest, 'BAD_ARGUMENTS',
          value: e.message);
    }
  }

  @Route.get('/')
  Future<Response> getMe(Request request) async {
    try {
      final user =
          await getUserFromRequest(request, getTokenRpc, getUserWithTokenRpc);
      return Response.ok(
        json.encode(
          MeResponseData(user.id, user.email, user.accountType).toJson(),
        ),
      );
    } on NoAuthorizationHeaderError catch (_) {
      return errorResponse(
        HttpStatus.badRequest,
        'AUTHORIZATION_HEADER_NEEDED',
      );
    } on NoTokenFoundError catch (_) {
      return errorResponse(HttpStatus.unauthorized, 'UNAUTHORIZED');
    } on UserNotFoundError catch (_) {
      return errorResponse(HttpStatus.notFound, 'USER_NOT_FOUND');
    }
  }

  @Route.post('/sign_in')
  Future<Response> signIn(Request request) async {
    final body = json.decode(await request.readAsString());
    final data = SignInRequestData.fromJson(body);
    final encryptedData = SignInRequestData(
        data.email, sha512.convert(data.password.codeUnits).toString());
    final user = await getUserWithEmailAndPasswordRpc.request(encryptedData);
    if (user == null) {
      return Response.notFound('');
    }
    final tokenLength = 256;
    final random = Random.secure();
    final tokenBytes = List.generate(tokenLength, (_) => random.nextInt(255));
    final token = DatabaseToken(user?.id, base64.encode(tokenBytes));
    await saveTokenRpc.request(token);
    return Response.ok(
      json.encode(SignInResponseData(token.token)),
    );
  }

  Router get router => _$UsersRouter(this);
}
