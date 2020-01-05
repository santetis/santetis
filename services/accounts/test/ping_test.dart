import 'package:accounts_service/accounts_service.dart';
import 'package:test/test.dart';

void main() {
  test('ping', () async {
    final accountsService = AccountsService();
    final response = accountsService.ping(null);
    expect(response.statusCode, 200);
    expect(await response.readAsString(), 'pong');
  });
}
