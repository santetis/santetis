import 'package:api/src/models/token.dart';

class NoTokenFoundError extends Error {}

void checkTokenExist(DatabaseToken token) {
  if (token == null) {
    throw NoTokenFoundError();
  }
}
