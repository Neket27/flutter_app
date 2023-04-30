import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_app/chat/chatListWidget.dart';
import '../Palette.dart';
import '../models/chatMessage.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ChatItemWidget extends StatelessWidget{
  int index;
  User _user;
  List<ChatMessage> messages=[];

  ChatItemWidget(this.index,this._user,this.messages);


  @override
  Widget build(BuildContext context) {

//  print('this='+messages[index].user);
    if (messages[index].Login==_user.username) {
      //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
      return Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text( messages[index].MessageText,
                    style: TextStyle(color: Palette.selfMessageColor, fontSize: 14),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Palette.selfMessageBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(right: 10.0),
                )
              ],
              mainAxisAlignment:
              MainAxisAlignment.end, // aligns the chatitem to right end
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.now()),
                      style: TextStyle(
                          color: Palette.greyColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.normal),
                    ),
                    margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                  )])
          ]));
    } else {
      // This is a received message
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    messages[index].MessageText,
                    style: TextStyle(color: Palette.otherMessageColor,fontSize: 14),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Palette.otherMessageBackgroundColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
            Container(
              child: Text(
                DateFormat('dd MMM kk:mm')
                    .format(DateTime.now()),
                style: TextStyle(
                    color: Palette.greyColor,
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal),
              ),
              margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }  }

}