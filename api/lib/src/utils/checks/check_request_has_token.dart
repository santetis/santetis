import 'dart:io';

import 'package:shelf/shelf.dart';

class NoAuthorizationHeaderError extends Error {}

void checkRequestHasToken(Request request) {
  if (!request.headers.containsKey(HttpHeaders.authorizationHeader)) {
    throw NoAuthorizationHeaderError();
  }
}
