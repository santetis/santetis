import 'dart:async';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class GetUserWithTokenRpc extends Rpc<int, DatabaseUser> {
  final GetUserWithTokenFromDatabase _getUserWithTokenFromDatabase;

  GetUserWithTokenRpc(this._getUserWithTokenFromDatabase);

  @override
  FutureOr<DatabaseUser> request(int input) async {
    final data = await _getUserWithTokenFromDatabase.request(input);
    if (data.isEmpty) {
      return null;
    }
    return DatabaseUser.fromJson(data.first['users']);
  }
}

class GetUserWithTokenFromDatabase
    extends Rpc<int, List<Map<String, dynamic>>> {
  final SharedPool<PostgreSQLConnection> _pool;

  GetUserWithTokenFromDatabase(this._pool);

  @override
  FutureOr<List<Map<String, dynamic>>> request(int input) async {
    final conn = await _pool.get();
    final data = conn.connection.mappedResultsQuery(
        'SELECT * FROM users WHERE id = @id',
        substitutionValues: {
          'id': input,
        });
    await conn.release();
    return data;
  }
}
