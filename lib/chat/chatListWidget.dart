import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/chatMessage.dart';
import 'chatItemWidget.dart';

class ChatListWidget extends StatefulWidget{
  ChatListWidget ({Key? key}):super(key: key);


  final ScrollController listScrollController = new ScrollController();
  late List<ChatMessage> _messages=[];
  ChatMessage chatMessage =ChatMessage(date: "2014-02-11T14:41:17.000Z",
      user: "Neket",
      message: "Dave changed the subject to “Test Chat",
      type: "action");

  //String jsonString = '{"keyDialog_1":{"userMessage":["hey","Как твои дела"],"myMessage":["У меня всё хорошо","Как твои дела?"]}}';




  String jsonString ='{"data":[{"date":"2014-02-11T14:41:17.000Z","user":"Dave","message":"Dave changed the subject to “Test Chat”","type":"action"}, {"date":"2014-02-11T14:42:43.000Z","user":"John","message":"Still testing...?","type":"message"}]}';
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  @override
  State<ChatListWidget> createState() {
    return new _ChatListWidgetState();
  }
}

  class _ChatListWidgetState extends State<ChatListWidget>{


  _ChatListWidgetState(){
    loadJsonData();
    getData();
  }

  // List<ChatMessage> parseMessages(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<ChatMessage>((json) => ChatMessage.fromJson(json)).toList();
  // }

  @override
  void initState() {
    super.initState();
    loadJsonData();
    widget._messages.add(widget.chatMessage);
    getData();
    print('messages='+widget._messages[0].user);
  }

  getData() async {
    try {
      final url = Uri.parse('https://1928aec5-0ac4-42d7-a5ad-29a0d6161e41.mock.pstmn.io/test/message');

      var response = await http.get(url);
      print('Ответ');
      print(response.body.toString());
    } catch (error) {
      print("EERROR: $error");
    }
  }

  Future<void> loadJsonData() async {
    final jsonString = await rootBundle.loadString('jsons/message.json');
    final jsonResponse = json.decode(jsonString);

    List<dynamic> data = jsonResponse['data'];

    setState(() {
      widget._messages = data.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    print('messages='+widget._messages[0].user);
    return Flexible(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => ChatItemWidget(index,widget._messages),
          itemCount: widget._messages.length,
          reverse: true,
          controller: widget.listScrollController,
        )

    );
  }

}