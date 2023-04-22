import 'package:flutter/material.dart';
import 'package:project_app/convertor/conversationPage.dart';

import '../models/user.dart';


class ConversationPageList extends StatelessWidget  {
  late  User user;

  ConversationPageList(User user){
    this.user =user;
  }

  onversationPageList(User user){

  }
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
        ConversationPage(user),
        ConversationPage(user),
        ConversationPage(user)
      ],
    );


  }
}