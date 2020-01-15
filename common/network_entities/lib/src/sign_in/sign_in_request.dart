import 'package:json_annotation/json_annotation.dart';
import 'package:crypto/crypto.dart';

part 'sign_in_request.g.dart';

String encodePassword(String password) =>
    sha512.convert(password.codeUnits).toString();

@JsonSerializable()
class SignInRequestData {
  final String email;
  @JsonKey(fromJson: encodePassword)
  final String password;

  SignInRequestData(this.email, this.password);

  factory SignInRequestData.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestDataToJson(this);
}
