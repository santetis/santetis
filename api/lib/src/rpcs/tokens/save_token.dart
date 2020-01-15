import 'dart:async';

import 'package:api/src/models/token.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class SaveTokenRpc extends Rpc<DatabaseToken, void> {
  final SaveTokenInDatabase _saveTokenInDatabase;

  SaveTokenRpc(this._saveTokenInDatabase);

  @override
  FutureOr<void> request(DatabaseToken input) =>
      _saveTokenInDatabase.request(input);
}

class SaveTokenInDatabase extends Rpc<DatabaseToken, void> {
  final SharedPool<PostgreSQLConnection> _pool;

  SaveTokenInDatabase(this._pool);

  @override
  FutureOr<void> request(DatabaseToken input) async {
    final conn = await _pool.get();
    await conn.connection.execute(
      'INSERT INTO tokens (user_id, token) VALUES (@user_id, @token)',
      substitutionValues: input.toJson(),
    );
    await conn.release();
  }
}
