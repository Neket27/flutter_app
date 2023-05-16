// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DialogListElm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialogListElm _$DialogListElmFromJson(Map<String, dynamic> json) => DialogListElm(
      Login: json['Login'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      Unread: json['Unread'] as int,
);

Map<String, dynamic> _$DialogListElmToJson(DialogListElm instance) =>
    <String, dynamic>{
      'Login': instance.Login,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'Unread': instance.Unread,
    };
