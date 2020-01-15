import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class DatabaseToken {
  @JsonKey(name: 'user_id')
  final int userId;
  final String token;

  DatabaseToken(this.userId, this.token);

  factory DatabaseToken.fromJson(Map<String, dynamic> json) =>
      _$DatabaseTokenFromJson(json);

  Map<String, dynamic> toJson() => _$DatabaseTokenToJson(this);
}
