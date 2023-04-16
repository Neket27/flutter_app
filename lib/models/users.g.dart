// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users()
  ..users = json['users'] as List<dynamic>
  ..total = json['total'] as num
  ..skip = json['skip'] as num
  ..limit = json['limit'] as num;

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'users': instance.users,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };
