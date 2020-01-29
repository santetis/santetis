import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

Response errorResponse(int statusCode, String errorKey) {
  return Response(
    statusCode,
    body: json.encode({'error': errorKey}),
    headers: {
      HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    },
  );
}
