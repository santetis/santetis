import 'dart:io';

import 'package:api/api.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? 'unknown') ?? 8080;

  final api = Api();

  await io.serve(api.router.handler, InternetAddress.anyIPv4, port);
}
