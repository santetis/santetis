import 'package:mobx/mobx.dart';

part 'user.g.dart';

class UserState = UserStateBase with _$UserState;

abstract class UserStateBase with Store {
  @observable
  String email;
}
