import 'package:json_annotation/json_annotation.dart';

part 'me_response.g.dart';

enum AccountType {
  admin,
  pharmacist,
  doctor,
  nurse,
}

@JsonSerializable()
class MeResponseData {
  final int id;
  final String email;
  final AccountType accountType;

  MeResponseData(this.id, this.email, this.accountType);

  factory MeResponseData.fromJson(Map<String, dynamic> json) =>
      _$MeResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseDataToJson(this);
}
