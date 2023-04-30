import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class ChatMessage {
  final String sender;
  final String message;
  ChatMessage({required this.sender, required this.message});
}


class ChatData {
  Future<List<ChatMessage>> loadChatData() async {
    final jsonString = await rootBundle.loadString('[{"sender": "Alice","message": "Hello Bob"},{"sender": "Bob","message": "Hi Alice"},{"sender": "Alice","message": "How are you doing?"}]');
    final jsonData = json.decode(jsonString);
    return List<ChatMessage>.from(
        jsonData.map((data) => ChatMessage(sender: data['sender'], message: data['message'])));
  }
}


class ChatWidget extends StatelessWidget {
  final ChatData chatData = ChatData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chatData.loadChatData(),
      builder: (context, snapshot) {
        print('99999999999999999999999999999999999999999999999999999999999');
        print(snapshot.data );
        if (snapshot.hasData ) {
          final List<ChatMessage> messages = snapshot.data as List<ChatMessage>;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final ChatMessage message = messages[index];
              return ListTile(
                title: Text(message.sender),
                subtitle: Text(message.message),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
