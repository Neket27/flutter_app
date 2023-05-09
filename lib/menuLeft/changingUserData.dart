import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import '../home/home.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ChangingUserData extends StatelessWidget {

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = new GlobalKey<FormState>();
  String textButtonUpdate ='Применить изменения';
  late String _newPass;
  late String _firstName;
  late String _lastName;
  User _user;
  ChangingUserData(this._user);
  @override
  setState(){

  }
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
  _context=context;
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
                      onSaved: (val) => _firstName = val!,
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
                      onSaved: (val) => _lastName = val!,
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
                      onSaved: (val) => _newPass = val!,
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
                  new Padding(
                    padding: new EdgeInsets.only(top: 25.0),
                    child: new MaterialButton(
                      onPressed: UploadAvatar,
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: 150.0,
                      child: new Text(
                        "Загрузить аватар",
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
  void UploadAvatar() async{
    var request = http.MultipartRequest("POST", Uri.http('195.19.114.66:8888', 'whatsit/create'));
    request.fields["Login"] = _user.username;
    request.fields["Password"] = _user.password;
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (res != null) {
      var pic = await http.MultipartFile.fromPath(
          "Avatar", res.files.single.path.toString());
      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        showDialog(
          context: _context,
          builder: (_) =>
              AlertDialog(
                title: Text(""),
                content: Text('Аватар успешно загружен'),
              ),
        );
      } else {
        showDialog(
          context: _context,
          builder: (_) =>
              AlertDialog(
                title: Text(""),
                content: Text('Ошибка'),
              ),
        );
      }
    }
  }
  void UpdateDataUser() async{
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      var response =await  http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
          body:  '{"RequestType":"UpdateUserInfo","Login":"${_user.username}","Password":"${_user.password}","NewPassword": "${_newPass}","NewFstName": "${_firstName}","NewLstName": "${_lastName}"}'
      );
      // 200 - успех 418 неправильный логин или пароль остальное чет не так с запросом
      print(response.statusCode);
      if(response.statusCode==200) {
        //TODO крч тут обновляем данные нашего юзера на устройстве, мне он чет не дает структуру менять
      //  _user=
      //  _user.password=_newPass;
        //_user.firstName=_firstName;
       // _user.lastName=_lastName;
        setState() {
          textButtonUpdate = 'Данные изменены';
          print('изменение');
          // Timer.periodic(Duration(seconds: 5), (_) {
          //   textButtonUpdate = 'Применить';
          // });
        }
      }
    }
  }


  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}

