import 'package:api/src/models/user.dart';
import 'package:network_entities/network_entities.dart';

class NotAnAdminUserError extends Error {}

void checkIsAdminUser(DatabaseUser user) {
  if (user.accountType != AccountType.admin) {
    throw NotAnAdminUserError();
  }
}
