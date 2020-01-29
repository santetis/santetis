import 'package:api/src/models/user.dart';

class UserAlreadyExistError extends Error {}

void checkUserAlreadyExist(DatabaseUser user) {
  if (user != null) {
    throw UserAlreadyExistError();
  }
}
