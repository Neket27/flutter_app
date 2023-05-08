import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../convertor/conversationPage.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;


class MessageWithPeople  extends StatefulWidget{
  User _userMe;
  User _user;
  int _unreadMessages;

  MessageWithPeople (this._userMe,this._user,this._unreadMessages);

  @override
  State<MessageWithPeople> createState() {
  return new _MessageWithPeopleState();
  }
}

class _MessageWithPeopleState extends State<MessageWithPeople>{
  List<User> _users=[];
  _MessageWithPeopleState(){
    loadJsonData();
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final jsonString = await rootBundle.loadString('jsons/users.json');
    final jsonResponse = json.decode(jsonString);

    List<dynamic> data = jsonResponse['users'];

    setState(() {
      _users = data.map((dynamic item) => User.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return
      Padding(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromRGBO(254, 240, 220, 200),
              border: Border.all(color: Colors.black26)),
          child: new ListTile(
              title: new Text(widget._user.firstName+" "+ widget._user.lastName+" Непрочитанных: "+widget._unreadMessages.toString()),
              onTap: () {_screenMassegeWithPeople(context);}
          ),
        ),
      );
  }

  void _screenMassegeWithPeople(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> ConversationPage(widget._userMe,widget._user)));
  }
}