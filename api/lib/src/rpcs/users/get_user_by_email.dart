import 'dart:async';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class GetUserByEmailRpc extends Rpc<String, DatabaseUser> {
  final GetUserByEmailFromDatabase _getUserByEmailFromDatabase;

  GetUserByEmailRpc(this._getUserByEmailFromDatabase);

  @override
  FutureOr<DatabaseUser> request(String input) async {
    await _getUserByEmailFromDatabase.request(input);
    // print(data);
    return null;
  }
}

class GetUserByEmailFromDatabase
    extends Rpc<String, List<Map<String, dynamic>>> {
  final SharedPool<PostgreSQLConnection> _pool;

  GetUserByEmailFromDatabase(this._pool);

  @override
  FutureOr<List<Map<String, dynamic>>> request(String input) async {
    final conn = await _pool.get();
    final data = conn.connection.mappedResultsQuery(
      'SELECT * FROM users WHERE email = @email',
      substitutionValues: {
        'email': input,
      },
    );
    await conn.release();
    return data;
  }
}
