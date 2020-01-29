import 'package:json_annotation/json_annotation.dart';
import 'package:network_entities/network_entities.dart';

part 'create_user_request.g.dart';

@JsonSerializable(nullable: false)
class CreateUserRequestData {
  @JsonKey(disallowNullValue: true, required: true)
  final String email;
  @JsonKey(disallowNullValue: true, required: true)
  final String password;
  @JsonKey(name: 'account_type', disallowNullValue: true, required: true)
  final AccountType accountType;

  CreateUserRequestData(this.email, this.accountType, this.password);

  factory CreateUserRequestData.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestDataToJson(this);
}
