// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatabaseToken _$DatabaseTokenFromJson(Map<String, dynamic> json) {
  return DatabaseToken(
    json['user_id'] as int,
    json['token'] as String,
  );
}

Map<String, dynamic> _$DatabaseTokenToJson(DatabaseToken instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
    };
