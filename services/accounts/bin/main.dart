import 'dart:io';

import 'package:accounts_service/accounts_service.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? 'unknown') ?? 8080;

  final showcase = AccountsService();

  await io.serve(showcase.router.handler, InternetAddress.anyIPv4, port);
}
