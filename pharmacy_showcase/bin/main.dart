import 'dart:io';

import 'package:pharmacy_showcase/pharmacy_showcase.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? 'unknown') ?? 8080;

  final showcase = PharmacyShowcase();
  var staticHandler = createStaticHandler(
    './static',
    serveFilesOutsidePath: false,
    listDirectories: false,
  );

  final handler =
      Cascade().add(staticHandler).add(showcase.router.handler).handler;
  await io.serve(handler, InternetAddress.anyIPv4, port);
}
