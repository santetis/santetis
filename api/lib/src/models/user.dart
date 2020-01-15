import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum AccountType {
  admin,
  pharmacist,
  doctor,
  nurse,
}

@JsonSerializable()
class DatabaseUser {
  @JsonKey(includeIfNull: false)
  final int id;
  final String email;
  final String password;
  @JsonKey(name: 'account_type')
  final AccountType accountType;
  @JsonKey(name: 'created_on')
  final DateTime createdOn;
  @JsonKey(name: 'last_login')
  final DateTime lastLogin;

  DatabaseUser(this.email, this.password, this.accountType, this.createdOn,
      {this.lastLogin, this.id});

  factory DatabaseUser.fromJson(Map<String, dynamic> json) =>
      _$DatabaseUserFromJson(json);

  Map<String, dynamic> toJson() => _$DatabaseUserToJson(this);
}
