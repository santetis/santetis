import 'package:conn_pool/conn_pool.dart';
import 'package:postgres/postgres.dart';

class PostgresManager extends ConnectionManager<PostgreSQLConnection> {
  final String host;
  final int port;
  final String databaseName;
  final String username;
  final String password;
  final bool useSsl;
  final int timeoutInSeconds;
  final String timeZone;

  PostgresManager(this.databaseName,
      {this.host = 'localhost',
      this.port = 5432,
      this.username = 'postgres',
      this.password,
      this.useSsl = false,
      this.timeoutInSeconds = 30,
      this.timeZone = 'UTC'});

  @override
  Future<PostgreSQLConnection> open() async {
    final conn = PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
      useSSL: useSsl,
      timeoutInSeconds: timeoutInSeconds,
      timeZone: timeZone,
    );
    await conn.open();
    return conn;
  }

  @override
  Future<void> close(PostgreSQLConnection connection) {
    return connection.close();
  }
}
