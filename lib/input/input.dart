import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/home.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Input extends StatelessWidget {

  late String _login;
  late String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Form(
              key: formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(labelText: "Вход"),
                      keyboardType: TextInputType.emailAddress,
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
                      decoration: new InputDecoration(labelText: "Password"),
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
                      onPressed: submitLogin,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Вход",
                        style: _sizeTextWhite,
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: submitReg,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Регистрация",
                        style: _sizeTextWhite,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  void submitLogin() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void submitReg() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      performReg();
    }
  }

  void  performLogin() async{//TODO по смыслу ipшник где нибудь в одном месте хранить
    var response =await  http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
         body:  '{"RequestType":"Autorization","Login":"${_login}","Password": "${_password}"}'
     );
    // 200 - успех 418 неправильный логин или пароль остальное чет не так с запросом
    if(response.statusCode==200) {
      print('STATE=OK ${_login} ${_password}');
      hideKeyboard();
      Navigator.push(
          _context,
          new MaterialPageRoute(
              builder: (context) {
                return new Home(new User(username: _login,password: _password, online: true));
              }
          ));
    }else if(response.statusCode==418){
      showDialog(
        context: _context,
        builder: (_) => AlertDialog(
          title: Text(""),
          content: Text('Неправильный логин или пароль'),
        ),
      );
    }else{
    showDialog(
    context: _context,
    builder: (_) => AlertDialog(
    title: Text(""),
    content: Text('Ошибка'),
    ),
    );
    }
  }

  void performReg() async{
    var response =await  http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
        body:  '{"RequestType":"Registration","Login":"${_login}","Password": "${_password}"}'
    );
    if(response.statusCode==200) {
      //TODO сохраняем логин и пароль для дальнейших запросов
      showDialog(
        context: _context,
        builder: (_) => AlertDialog(
          title: Text(""),
          content: Text('Регистрация прошла успешно'),
        ),
      );
      hideKeyboard();
      Navigator.push(
          _context,
          new MaterialPageRoute(
              builder: (context) {
                return new Home(new User(username: _login,password: _password, online: true));
              }
          ));
    }
     else if(response.statusCode==418){
        showDialog(
          context: _context,
          builder: (_) => AlertDialog(
            title: Text(""),
            content: Text('Логин занят'),
          ),
        );
      }else{
        showDialog(
          context: _context,
          builder: (_) => AlertDialog(
            title: Text(""),
            content: Text('Ошибка'),
          ),
        );
      }

  }


  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}

