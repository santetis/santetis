class BodyIsEmptyError extends Error {}

void checkBodyIsEmpty(String body) {
  if (body == null || body.isEmpty) {
    throw BodyIsEmptyError();
  }
}
