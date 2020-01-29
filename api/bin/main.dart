import 'dart:io';

import 'package:api/api.dart';
import 'package:api/src/postgres_manager.dart';
import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/tokens/save_token.dart';
import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:api/src/rpcs/users/get_user_from_token.dart';
import 'package:api/src/rpcs/users/get_user_with_email_and_password.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? 'unknown') ?? 8080;
  final databaseUsername = Platform.environment['DATABASE_USERNAME'];
  final databasePassword = Platform.environment['DATABASE_PASSWORD'];
  final databaseHost = Platform.environment['DATABASE_HOST'];
  final databasePort =
      int.tryParse(Platform.environment['DATABASE_PORT'] ?? 'unknown') ?? 8080;
  final databaseName = Platform.environment['DATABASE_NAME'];

  final pool = SharedPool<PostgreSQLConnection>(
    PostgresManager(
      databaseName,
      username: databaseUsername,
      password: databasePassword,
      host: databaseHost,
      port: databasePort,
    ),
    minSize: 1,
    maxSize: 20,
  );

  final getUserByEmailFromDatabase = GetUserByEmailFromDatabase(pool);
  final getUserByEmailRpc = GetUserByEmailRpc(getUserByEmailFromDatabase);
  final createUserInDatabase = CreateUserInDatabase(pool);
  final createUserRpc = CreateUserRpc(createUserInDatabase);
  final getUserWithEmailAndPasswordFromDatabase =
      GetUserWithEmailAndPasswordFromDatabase(pool);
  final getUserWithEmailAndPasswordRpc =
      GetUserWithEmailAndPasswordRpc(getUserWithEmailAndPasswordFromDatabase);
  final saveTokenInDatabase = SaveTokenInDatabase(pool);
  final saveTokenRpc = SaveTokenRpc(saveTokenInDatabase);
  final getTokenFromDatabase = GetTokenFromDatabase(pool);
  final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
  final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabase(pool);
  final getUserWithTokenRpc = GetUserWithTokenRpc(getUserWithTokenFromDatabase);

  final api = Api(
    getUserByEmailRpc: getUserByEmailRpc,
    createUserRpc: createUserRpc,
    getUserWithEmailAndPasswordRpc: getUserWithEmailAndPasswordRpc,
    saveTokenRpc: saveTokenRpc,
    getTokenRpc: getTokenRpc,
    getUserWithTokenRpc: getUserWithTokenRpc,
  );

  await io.serve(api.handler, InternetAddress.anyIPv4, port);
}
