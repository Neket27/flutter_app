import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ChangingUserData extends StatelessWidget {

  late String _login;
  late String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  String textButtonUpdate ='Применить изменения';

  @override
  setState(){

  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Редактирование данных'),),
        ),
        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Имя"),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _login = val!,
                      // validator: (val) =>
                      //     !val!.contains("@") ? 'Not a valid email.' : null,
                    ),
                    width: 400.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Фамилия"),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      style: _sizeTextBlack,
                      onSaved: (val) => _login = val!,
                      // validator: (val) =>
                      //     !val!.contains("@") ? 'Not a valid email.' : null,
                    ),
                    width: 400.0,
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Пароль"),
                      obscureText: true,
                      maxLines: 1,
                      validator: (val) =>
                      val!.length < 6 ? 'Короткий пароль.' : null,
                      onSaved: (val) => _password = val!,
                      style: _sizeTextBlack,
                    ),
                    width: 400.0,
                    padding: new EdgeInsets.only(top: 10.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: UpdateDataUser,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        textButtonUpdate,
                        style: _sizeTextWhite,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void UpdateDataUser() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();

      setState() {
        textButtonUpdate = 'Данные изменены';
        print('изменение');
        // Timer.periodic(Duration(seconds: 5), (_) {
        //   textButtonUpdate = 'Применить';
        // });
      }
    }
  }


  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}
