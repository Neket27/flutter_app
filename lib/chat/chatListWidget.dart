import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../models/chatMessage.dart';
import '../models/user.dart';
import 'chatItemWidget.dart';
class ChatListWidget extends StatefulWidget{

  User _user;
  ChatListWidget (this._user);


  final ScrollController listScrollController = new ScrollController();
  late List<ChatMessage> _messages=[];

  ChatMessage chatMessage =ChatMessage(
      Date: "2014-02-11T14:41:17.000Z",
      Login: "Neket",
      MessageText: "Dave changed the subject to “Test Chat",
  );
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
    print('messages='+widget._messages[0].Login);
  }

  Future<String> getData() async {
    try {
      //TODO: брать свой логин, пароль и текущего собеседника
      var response = await http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
          body: '{"RequestType":"GetDialog","Login":"${widget._user.username}","Password": "${widget._user.password}","LoginRcv":"${widget._user}"}'
      );
      //final url = Uri.parse('https://1928aec5-0ac4-42d7-a5ad-29a0d6161e41.mock.pstmn.io/test/message');

      //-var response = await http.get(url);
      print('Ответ');
      print(response.body.toString());
      return response.body;
    } catch (error) {
      print("EERROR: $error");
    }
    return "";
  }

  Future<void> loadJsonData() async {
    //final jsonString = await rootBundle.loadString('jsons/message.json');
   // final jsonResponse = json.decode(jsonString);

    //List<dynamic> data = jsonResponse['data'];
    String jsonstr=await getData();
    final jsonResponse = json.decode(jsonstr);
    List<dynamic> data = jsonResponse['Messages'];
    setState(() {
      widget._messages = data.map((dynamic item) => ChatMessage.fromJson(item)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    print('messages='+widget._messages[0].Login);
    return Flexible(
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => ChatItemWidget(index,widget._user,widget._messages),
          itemCount: widget._messages.length,
          reverse: true,
          controller: widget.listScrollController,
        )

    );
  }

}