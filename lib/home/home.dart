import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/menuLeft/panelMenu.dart';
import 'package:project_app/models/user.dart';

import '../people/messageWithPeoples.dart';
import 'SearchUser.dart';
import 'windowSearchUser.dart';

class Home extends StatefulWidget {
  User _user;
  List<dynamic>? data ;

  Home(this._user,this.data);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKeyMenuPerson = GlobalKey();
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
      widget.data = jsonResponse['Dialogs'];
    }
    print("DATA_Dialogs=${widget.data?.length}");
  }

  @override
  Widget build(BuildContext context) {
   // getData();

    print('lengchDATA=${widget.data?.length}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:    Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () =>
                  _globalKeyMenuPerson.currentState!.openDrawer(),
              child: Icon(Icons.menu),
            ),
            //  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded),),
            Text(
              'Переписки',
            ),
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: SearchUser(widget._user)
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        toolbarHeight: 35,
      ),
      key: _globalKeyMenuPerson,
      drawer: PanelMenu(widget._user),
      body:
            Scaffold(
              body: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  backgroundColor: Color.fromRGBO(254, 240, 220, 10),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 1, right: 10),
                      child: Container(
                        child: Drawer(
                          width: 400,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return MessageWithPeople(widget._user,User(username: (widget.data?[index])['Login'],password: "",firstName: (widget.data?[index])['FirstName'],lastName:(widget.data?[index])['LastName']),(widget.data?[index])['Unread']);
                            },
                            itemCount: widget.data?.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


    );
  }
}
