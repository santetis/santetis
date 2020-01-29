import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

Response errorResponse(int statusCode, String errorKey, {value}) {
  return Response(
    statusCode,
    body: json.encode({
      'error': errorKey,
      if (value != null) 'value': value,
    }),
    headers: {
      HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    },
  );
}
