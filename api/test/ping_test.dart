import 'package:api/src/api/api.dart';
import 'package:test/test.dart';

void main() {
  test('ping', () async {
    final accountsService = Api(
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: null,
      getUserByEmailRpc: null,
      saveTokenRpc: null,
    );
    final response = accountsService.ping(null);
    expect(response.statusCode, 200);
    expect(await response.readAsString(), 'pong');
  });
}
