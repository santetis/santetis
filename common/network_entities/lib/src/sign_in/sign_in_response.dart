import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponseData {
  final String token;

  SignInResponseData(this.token);

  factory SignInResponseData.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseDataToJson(this);
}
