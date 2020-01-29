import 'dart:io';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/users/get_user_from_token.dart';
import 'package:api/src/utils/checks/check_request_has_token.dart';
import 'package:api/src/utils/checks/check_token_exist.dart';
import 'package:api/src/utils/checks/check_user_exist.dart';
import 'package:shelf/shelf.dart';

Future<DatabaseUser> getUserFromRequest(Request request,
    GetTokenRpc getTokenRpc, GetUserWithTokenRpc getUserWithTokenRpc) async {
  checkRequestHasToken(request);
  final authorizationHeaderValue =
      request.headers[HttpHeaders.authorizationHeader];
  final token = await getTokenRpc.request(authorizationHeaderValue);
  checkTokenExist(token);
  final user = await getUserWithTokenRpc.request(token.userId);
  checkUserExist(user);
  return user;
}
