import 'package:json_annotation/json_annotation.dart';

part 'chatMessage.g.dart';

@JsonSerializable()
class ChatMessage {
  final String Date;
  final String Login;
  final String MessageText;
  ChatMessage({
    required this.Date,
    required this.Login,
    required this.MessageText,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}