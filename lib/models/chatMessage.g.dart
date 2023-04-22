// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      date: json['date'] as String,
      user: json['user'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'date': instance.date,
      'user': instance.user,
      'message': instance.message,
      'type': instance.type,
    };
