import 'dart:async';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class CreateUserRpc extends Rpc<DatabaseUser, void> {
  final CreateUserInDatabase _createUserInDatabase;

  CreateUserRpc(this._createUserInDatabase);

  @override
  Future<void> request(DatabaseUser input) =>
      _createUserInDatabase.request(input);
}

class CreateUserInDatabase extends Rpc<DatabaseUser, void> {
  final SharedPool<PostgreSQLConnection> _pool;

  CreateUserInDatabase(this._pool);

  @override
  Future<void> request(DatabaseUser input) async {
    final conn = await _pool.get();
    await conn.connection.mappedResultsQuery(
      'INSERT INTO users (email, password, account_type, created_on) VALUES (@email, @password, @account_type, @created_on)',
      substitutionValues: input.toJson(),
    );
    await conn.release();
  }
}
