import 'dart:async';
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
  String _RcvLogin;
  ChatListWidget (this._user,this._RcvLogin);

  final ScrollController listScrollController = new ScrollController();
  late List<ChatMessage> _messages=[];

  @override
  State<ChatListWidget> createState() {
    return new _ChatListWidgetState();
  }
}

  class _ChatListWidgetState extends State<ChatListWidget>{
  _ChatListWidgetState(){
    getData();
  }

  @override
  void initState() {
    super.initState();
    widget._messages=[];
    getData();
    Timer.periodic(Duration(seconds: 1), (_) {
      getData();
      print('Обновление json');
    });
  }

  Future<void> getData() async {
    try {
      var response = await http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
          body: '{"RequestType":"GetDialog","Login":"${widget._user.username}","Password": "${widget._user.password}","LoginRcv":"${widget._RcvLogin}"}'
      );
      print('Ответ');
      print(response.body.toString());
      final jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['Messages'];
      setState(() {
        widget._messages = data.map((dynamic item) => ChatMessage.fromJson(item)).toList();
      });
    } catch (error) {
      print("EERROR: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
      return Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) =>
                ChatItemWidget(index, widget._user, widget._messages),
            itemCount: widget._messages.length,
            reverse: true,
            controller: widget.listScrollController,
          )

      );
  }
}