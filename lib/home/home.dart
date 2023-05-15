import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/menuLeft/panelMenu.dart';
import 'package:project_app/models/user.dart';
import 'package:project_app/home/SearchUser.dart';

import 'windowSearchUser.dart';

class Home extends StatefulWidget {
  User _user;

  Home(this._user);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKeyMenuPerson = GlobalKey();
  List<dynamic>? data = [];

  @override
  void setState(VoidCallback fn) {
    getData();
    super.setState(fn);
  }

  @override
  initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var response = await http.post(Uri.http('195.19.114.66:8888'),
        headers: {'Accept': 'application/json'},
        body:
            "{\"RequestType\":\"GetDialogsList\",\"Login\":\"${widget._user.username}\",\"Password\": \"${widget._user.password}\"}");

    //Коды ответа: 200 успех,400 неправильно составлен запрос, 418 неправильный логин/пароль
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      data = jsonResponse['Dialogs'];
    }
    print("DATA_Dialogs=${data?.length}");
  }

  @override
  Widget build(BuildContext context) {
    getData();

    print('lengchDATA=${data?.length}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(''),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        toolbarHeight: 25,
      ),
      key: _globalKeyMenuPerson,
      drawer: PanelMenu(widget._user),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () =>
                        _globalKeyMenuPerson.currentState!.openDrawer(),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  //  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded),),
                  Text(
                    'Переписки',
                  ),
                  IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: SearchUser()
                        );
                      //  Navigator.of(context).push(MaterialPageRoute(
                      //      builder: (context) => windowSearchUser()));
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        size: 30,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
