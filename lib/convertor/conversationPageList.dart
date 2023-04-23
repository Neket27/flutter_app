import 'package:flutter/material.dart';
import 'package:project_app/convertor/conversationPage.dart';

import '../models/user.dart';


class ConversationPageList extends StatelessWidget  {
  User _user;
  String _login;

  ConversationPageList(this._user, this._login);


//
//
//   @override
//   _ConversationPageListState createState() => _ConversationPageListState();
// }
//
// class _ConversationPageListState extends State<ConversationPageList> {

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        ConversationPage(_user,_login),
        ConversationPage(_user,_login),
        ConversationPage(_user,_login)
      ],
    );


  }
}