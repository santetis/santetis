// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeResponseData _$MeResponseDataFromJson(Map<String, dynamic> json) {
  return MeResponseData(
    json['id'] as int,
    json['email'] as String,
    _$enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
  );
}

Map<String, dynamic> _$MeResponseDataToJson(MeResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'accountType': _$AccountTypeEnumMap[instance.accountType],
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

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AccountTypeEnumMap = {
  AccountType.admin: 'admin',
  AccountType.pharmacist: 'pharmacist',
  AccountType.doctor: 'doctor',
  AccountType.nurse: 'nurse',
};
