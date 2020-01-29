import 'dart:async';

import 'package:api/src/models/token.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class GetTokenRpc extends Rpc<String, DatabaseToken> {
  final GetTokenFromDatabase _getTokenFromDatabase;

  GetTokenRpc(this._getTokenFromDatabase);

  @override
  Future<DatabaseToken> request(String input) async {
    final data = await _getTokenFromDatabase.request(input);
    if (data.isEmpty) {
      return null;
    }
    return DatabaseToken.fromJson(data.first['tokens']);
  }
}

class GetTokenFromDatabase extends Rpc<String, List<Map<String, dynamic>>> {
  final SharedPool<PostgreSQLConnection> _pool;

  GetTokenFromDatabase(this._pool);

  @override
  Future<List<Map<String, dynamic>>> request(String input) async {
    final conn = await _pool.get();
    final data = await conn.connection.mappedResultsQuery(
      'SELECT * FROM tokens WHERE token = @token',
      substitutionValues: {'token': input},
    );
    await conn.release();
    return data;
  }
}
