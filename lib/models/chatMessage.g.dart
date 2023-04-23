// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      Date: json['Date'] as String,
      Login: json['Login'] as String,
      MessageText: json['MessageText'] as String,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'Date': instance.Date,
      'Login': instance.Login,
      'MessageText': instance.MessageText,
    };
