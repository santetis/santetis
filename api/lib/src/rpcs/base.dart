import 'dart:async';

abstract class Rpc<Input, Output> {
  FutureOr<Output> request(Input input);
}
