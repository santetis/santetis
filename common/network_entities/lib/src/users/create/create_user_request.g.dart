// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequestData _$CreateUserRequestDataFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['email', 'password', 'account_type'],
      disallowNullValues: const ['email', 'password', 'account_type']);
  return CreateUserRequestData(
    json['email'] as String,
    _$enumDecode(_$AccountTypeEnumMap, json['account_type']),
    json['password'] as String,
  );
}

Map<String, dynamic> _$CreateUserRequestDataToJson(
        CreateUserRequestData instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'account_type': _$AccountTypeEnumMap[instance.accountType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$AccountTypeEnumMap = {
  AccountType.admin: 'admin',
  AccountType.pharmacist: 'pharmacist',
  AccountType.doctor: 'doctor',
  AccountType.nurse: 'nurse',
};
