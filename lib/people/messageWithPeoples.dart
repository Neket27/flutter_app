import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../convertor/conversationPageList.dart';
import '../models/user.dart';



class MessageWithPeople  extends StatefulWidget{
  String _login;
  int _unreadMessages;

  MessageWithPeople (this._login,this._unreadMessages);

  @override
  State<MessageWithPeople> createState() {
  return new _MessageWithPeopleState();
  }
}

class _MessageWithPeopleState extends State<MessageWithPeople>{
  List<User> _users = [];
 // String jsonString = '{"users":[{"id": 1,"username": "SammyShark","firstName": "Marcel","lastName": "Jones","maidenName": "Smith","online":true,"avatar":"assets/I.jpg"},{"id": 2,"username": "JesseOctopus","firstName": "Assunta","lastName": "Rath","maidenName": "Heller","online": false,"avatar":"assets/dima.jpg"},{"id": 3,"username": "DrewSquid","firstName": "Enoch","lastName": "Lynch","maidenName": "Heidenreich","online": false,"avatar":""}]}';
 // late List<User> users= <User>[];

    int? _id;
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

  // Future<List<User>> fetchUserList() async {
  //   //final jsonString = await loadJsonFromAsset();
  //   final jsonResponse = json.decode(jsonString);
  //   final userList = UserList.fromJson(jsonResponse);
  //    users = userList.users;
  //   return users;
  // }


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
              title: new Text(widget._login+" Непрочитанных: "+widget._unreadMessages.toString()),
              onTap: () {_screenMassegeWithPeople(context);}
          ),
        ),
      );

      // Drawer(
      //   child: ListView.builder(
      //     itemBuilder: (BuildContext context, int index) {
      //       return Padding(padding: EdgeInsets.only(left:10,top:10,right:10),
      //         child: Container(
      //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Color.fromRGBO(254,240,220,200), border: Border.all(color: Colors.black26)),
      //           child:  new ListTile(
      //               title: new Text(_users[index].firstName + ' '+_users[index].lastName),
      //               leading: CircleAvatar(backgroundImage: AssetImage(_users[index].avatar.toString()), radius: 20,),
      //               onTap: (){
      //                 setState(() {
      //                   _id=index;
      //                 });
      //                 _screenMassegeWithPeople(context);
      //               }
      //           ),
      //         ),
      //       );
      //     },
      //     itemCount: _users.length,
      //   ),
      // );
  }
  void _screenMassegeWithPeople(BuildContext context){
    User user = new User(id: 77, username: 'Neket', firstName: 'Kulga', lastName: 'lastName', online:true, avatar: '');


    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=> ConversationPageList(user)));
  }
}