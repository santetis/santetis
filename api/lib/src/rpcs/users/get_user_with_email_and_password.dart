import 'dart:async';

import 'package:api/src/models/user.dart';
import 'package:api/src/rpcs/base.dart';
import 'package:conn_pool/conn_pool.dart';
import 'package:network_entities/network_entities.dart';
import 'package:postgres/postgres.dart';

class GetUserWithEmailAndPasswordRpc
    extends Rpc<SignInRequestData, DatabaseUser> {
  final GetUserWithEmailAndPasswordFromDatabase
      _getUserWithEmailAndPasswordFromDatabase;

  GetUserWithEmailAndPasswordRpc(this._getUserWithEmailAndPasswordFromDatabase);

  @override
  FutureOr<DatabaseUser> request(SignInRequestData input) async {
    final data = await _getUserWithEmailAndPasswordFromDatabase.request(input);
    if (data.length == 1) {
      return DatabaseUser.fromJson(data.first['users']);
    }
    return null;
  }
}

class GetUserWithEmailAndPasswordFromDatabase
    extends Rpc<SignInRequestData, List<Map<String, dynamic>>> {
  final SharedPool<PostgreSQLConnection> _pool;

  GetUserWithEmailAndPasswordFromDatabase(this._pool);

  @override
  FutureOr<List<Map<String, dynamic>>> request(SignInRequestData input) async {
    final conn = await _pool.get();
    final data = conn.connection.mappedResultsQuery(
      'SELECT * FROM users WHERE email = @email AND password = @password',
      substitutionValues: input.toJson(),
    );
    await conn.release();
    return data;
  }
}
