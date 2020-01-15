import 'dart:io';

import 'package:api/src/postgres_manager.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

SharedPool<PostgreSQLConnection> createPool({String databaseName = 'rdb'}) {
  final databaseUsername = Platform.environment['DATABASE_USERNAME'];
  final databasePassword = Platform.environment['DATABASE_PASSWORD'];
  final databaseHost = Platform.environment['DATABASE_HOST'];
  final databasePort =
      int.tryParse(Platform.environment['DATABASE_PORT'] ?? 'unknown') ?? 8080;

  final pool = SharedPool<PostgreSQLConnection>(
    PostgresManager(
      databaseName,
      username: databaseUsername,
      password: databasePassword,
      host: databaseHost,
      port: databasePort,
    ),
    minSize: 1,
    maxSize: 1,
  );
  return pool;
}
