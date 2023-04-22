import 'package:json_annotation/json_annotation.dart';

part 'chatMessage.g.dart';

@JsonSerializable()
class ChatMessage {
  final String date;
  final String user;
  final String message;
  final String type;

  ChatMessage({
    required this.date,
    required this.user,
    required this.message,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}