import 'package:api/src/models/user.dart';

class UserNotFoundError extends Error {}

void checkUserExist(DatabaseUser user) {
  if (user == null) {
    throw UserNotFoundError();
  }
}
