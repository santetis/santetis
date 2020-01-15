// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestData _$SignInRequestDataFromJson(Map<String, dynamic> json) {
  return SignInRequestData(
    json['email'] as String,
    encodePassword(json['password'] as String),
  );
}

Map<String, dynamic> _$SignInRequestDataToJson(SignInRequestData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
