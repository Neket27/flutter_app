import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/menuLeft/panelMenu.dart';
import 'package:project_app/models/DialogListElm.dart';
import 'package:project_app/models/user.dart';

import '../people/messageWithPeoples.dart';
import 'SearchUser.dart';



class Home extends StatefulWidget {
  User _user;
  List<DialogListElm> data =[];

  Home(this._user);

  @override
  State<Home> createState() => HomeState();
}

 class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _globalKeyMenuPerson = GlobalKey();
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  initState() {
    getData();
    super.initState();
  }
 void updateUserData(String Login,String pass,String fname,String sname){
   setState(() {
     widget._user = User(
         username: Login, password: pass, firstName: fname, lastName: sname);
     print(widget._user.firstName);
   });
 }
  Future<void> getData() async {
    var response = await http.post(Uri.http('195.19.114.66:8888'),
        headers: {'Accept': 'application/json'},
        body:
            "{\"RequestType\":\"GetDialogsList\",\"Login\":\"${widget._user.username}\",\"Password\": \"${widget._user.password}\"}");

    //Коды ответа: 200 успех,400 неправильно составлен запрос, 418 неправильный логин/пароль
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> q = jsonResponse['Dialogs'];
      setState(() {
        widget.data =
            q.map((dynamic item) => DialogListElm.fromJson(item)).toList();
      });
    }
    print("DATA_Dialogs=${widget.data.length}");
  }

  @override
  Widget build(BuildContext context) {
    print('lengchDATA=${widget.data.length}');
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
                getData();
              },
              icon: const Icon(Icons.cached),
            ),
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: SearchUser(widget._user,this)
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
      drawer: PanelMenu(widget._user,this),
      body:
            Scaffold(

                  backgroundColor: Color.fromRGBO(254, 240, 220, 10),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 1, right: 10),
                      child: Container(
                        child: Drawer(
                          width: 400,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return MessageWithPeople(widget._user,User(username: (widget.data[index]).Login,password: "",firstName: (widget.data[index]).FirstName,lastName:(widget.data[index]).LastName),(widget.data[index]).Unread);
                            },
                            itemCount: widget.data.length,
                          ),
                        ),
                      ),
                    ),
                  ),

            ),


    );
  }
}
