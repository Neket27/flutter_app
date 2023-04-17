import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../convertor/conversationPageList.dart';



class MessageWithPeople  extends StatefulWidget{
  @override
  State<MessageWithPeople> createState() {
  return new _MessageWithPeopleState();
  }
}

class _MessageWithPeopleState extends State<MessageWithPeople>{

  @override
  Widget build(BuildContext context) {
      return
    Drawer(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(padding: EdgeInsets.only(left:10,top:10,right:10),
          child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Color.fromRGBO(254,240,220,200), border: Border.all(color: Colors.black26)),
          child:  new ListTile(
          title: new Text('kk'),
          leading: CircleAvatar(backgroundImage: AssetImage('assets/I.jpg'), radius: 20,),
          onTap: (){_screenMassegeWithPeople(context);}
          ),
          ),
          );
        },
        itemCount: 1,
      ),
    );
  }
  void _screenMassegeWithPeople(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>
       // Container(
       //   color: Color.fromRGBO(254,240,220,10),
       //     child: Column(
       //       children: [ChatListWidget(),InputWidget()],
       //     ),
       // ),

        ConversationPageList(),
    ));
  }
}