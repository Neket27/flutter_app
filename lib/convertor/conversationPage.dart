import 'package:flutter/material.dart';
import 'package:project_app/chat/chatAppBar.dart';
import 'package:project_app/chat/chatListWidget.dart';
import 'package:project_app/chat/inputWidget.dart';

import '../models/user.dart';
import '../people/messageWithPeoples.dart';


class ConversationPage  extends StatelessWidget  {
  User _userMe;
  User _userRm;

  ConversationPage(this._userMe, this._userRm);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: ChatAppBar(_userRm), // Custom app bar for chat screen
            body: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  ChatListWidget(_userMe,_userRm.username),//Chat list
                  InputWidget(_userMe,_userRm.username) // The input widget
                ],
              ),
            ]
            )
        )
    );
  }


}