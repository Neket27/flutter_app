import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Palette.dart';
import '../models/user.dart';

class InputWidget extends StatelessWidget {

  User _user;
  String _RcvLogin;

  InputWidget (this._user,this._RcvLogin);

  final TextEditingController textEditingController = new TextEditingController();
  late String _message;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                color: Palette.primaryColor, onPressed: () { },
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
    child: Material(
            child: Container(
              child: TextField(
                style: TextStyle(color: Palette.primaryTextColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Palette.greyColor),
                ),
              ),
            ),
    ),
          ),
          // Send Message Button
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => {_sendMessage()},
                color: Palette.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Palette.greyColor, width: 0.5)),
          color: Colors.white),
    );
  }

  Future<void> _sendMessage() async {
    textEditingController.clear();
    try {
      print(textEditingController.text);//TODO ошибка, хз почему не выдает текст
      var response = await http.post(Uri.http('195.19.114.66:8888'),
          body: '{"RequestType":"SendMessage","Login":"${_user.username}","Password": "${_user.password}","LoginRcv":"${_RcvLogin}","Message": "${textEditingController.text}"}'
      );
      print('Ответ');
      //print(response.body.toString());

    } catch (error) {
      print("EERROR: $error");
    }
  }
}