import 'dart:async';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class CreateUserRpc extends Rpc<DatabaseUser, void> {
  final CreateUserInDatabase _createUserInDatabase;

  CreateUserRpc(this._createUserInDatabase);

  @override
  FutureOr<void> request(DatabaseUser input) =>
      _createUserInDatabase.request(input);
}

class CreateUserInDatabase extends Rpc<DatabaseUser, void> {
  final SharedPool<PostgreSQLConnection> _pool;

  CreateUserInDatabase(this._pool);

  @override
  FutureOr<void> request(DatabaseUser input) async {
    final conn = await _pool.get();
    await conn.connection.mappedResultsQuery(
      'INSERT INTO users (email, password, accountType) VALUES (@email, @password, @accountType)',
      substitutionValues: input.toJson(),
    );
    await conn.release();
  }
}
