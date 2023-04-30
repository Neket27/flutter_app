import 'package:flutter/material.dart';
import 'package:project_app/chat/chatAppBar.dart';
import 'package:project_app/chat/chatListWidget.dart';
import 'package:project_app/chat/inputWidget.dart';

import '../models/user.dart';
import '../people/messageWithPeoples.dart';


class ConversationPage  extends StatelessWidget  {
  User _user;
  String _login;

  ConversationPage(this._user, this._login);

//   @override
//   _ConversationPageState createState() => _ConversationPageState();
// }
//
// class _ConversationPageState extends State<ConversationPage> {
//






  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ChatAppBar(_login), // Custom app bar for chat screen
            body: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  ChatListWidget(_user,_login),//Chat list
                  InputWidget(_user,_login) // The input widget
                ],
              ),
            ]
            )
        )
    );
  }


}