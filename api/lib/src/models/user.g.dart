// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatabaseUser _$DatabaseUserFromJson(Map<String, dynamic> json) {
  return DatabaseUser(
    json['email'] as String,
    json['password'] as String,
    _$enumDecodeNullable(_$AccountTypeEnumMap, json['account_type']),
    json['created_on'] == null
        ? null
        : DateTime.parse(json['created_on'] as String),
    lastLogin: json['last_login'] == null
        ? null
        : DateTime.parse(json['last_login'] as String),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$DatabaseUserToJson(DatabaseUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['email'] = instance.email;
  val['password'] = instance.password;
  val['account_type'] = _$AccountTypeEnumMap[instance.accountType];
  val['created_on'] = instance.createdOn?.toIso8601String();
  val['last_login'] = instance.lastLogin?.toIso8601String();
  return val;
}

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
