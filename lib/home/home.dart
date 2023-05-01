import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_app/home/carousel/carouselRecentPeople.dart';
import 'package:project_app/people/messageWithPeoples.dart';
import 'package:project_app/menuLeft/panelMenu.dart';
import 'package:project_app/models/user.dart';
import 'package:flutter/services.dart' show rootBundle;


class Home extends StatefulWidget {
  User _user;

  Home(this._user);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String jsonString = '{"users":[{"id": 1,"username": "SammyShark","firstName": "Marcel","lastName": "Jones","maidenName": "Smith","online":true},{"id": 2,"username": "JesseOctopus","firstName": "Assunta","lastName": "Rath","maidenName": "Heller","online": false},{"id": 3,"username": "DrewSquid","firstName": "Enoch","lastName": "Lynch","maidenName": "Heidenreich","online": false}]}';

// String response =  rootBundle.loadString(jsonString) as String;

//   Future<String> getJsonDate() {
//     return rootBundle.loadString('jsons/test.json');
//   }
//
//   User getJson() {
//     var r= rootBundle.loadString('jsons/test.json');
//     Map<String, dynamic> userMap = jsonDecode(r as String);
//     var user = User.fromJson(userMap);
//     return user;
//   }
//
// Future<User> getJson2() async {
//   String response = await rootBundle.loadString('jsons/test.json');
//   Map<String, dynamic> userMap = jsonDecode(response);
//   var user = User.fromJson(userMap);

//  return user;
//}

/////////////////////////////////
  final GlobalKey<ScaffoldState> _globalKeyMenuPerson = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromRGBO(254, 240, 220, 10),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Massage proger'),
            centerTitle: true,
            backgroundColor: Colors.deepPurpleAccent,
            toolbarHeight: 25,
          ),
          key: _globalKeyMenuPerson,
          drawer: PanelMenu(widget._user),

          body: SafeArea(
            child: Padding(padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: () =>
                          _globalKeyMenuPerson.currentState!.openDrawer(),
                        child: Icon(Icons.arrow_back_ios),),
                      //  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded),),
                      Text('Недавно писавшие люди',),
                      IconButton(onPressed: () {},
                          icon: Icon(Icons.search_rounded, size: 30,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Container(
                        width: 320,
                        //изменить на авто ширину !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        height: 250,
                        decoration: BoxDecoration(color: Colors.white,),
                        child: CarouselRecentPeople(),

                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Padding(padding: EdgeInsets.only(top: 260,),
                        child: ElevatedButton(
                            onPressed: () {
                              _screenMassege(context);
                            },
                            style: ButtonStyle(

                              backgroundColor: MaterialStateProperty.all(
                                  Colors.black),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(200, 40)),
                            ), child: Text('Переписки')
                        ),
                      ),

                    ],
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }

  //String jsonString = '{"users": [{"name": "John", "age": 30}, {"name": "Jane", "age": 25}]}';

  // Future<String> loadJsonFromAsset() async {
  //   return await rootBundle.loadString('assets/users.json');
  // }

  Future<UserList> fetchUserList() async {
    //final jsonString = await loadJsonFromAsset();
    final jsonResponse = json.decode(jsonString);
    final userList = UserList.fromJson(jsonResponse);
    return userList;
  }

  // getDataFromJson(){
  //
  //   Map<String, dynamic> data = json.decode(jsonString);
  //
  //   List<dynamic> users = data['users'];
  //   for (var user in users) {
  //     String name = user['name'];
  //     int age = user['age'];
  //     // do something with name and age
  //   }
  // }

// Future<List<User>> getDataFromFakeServer()async{
//   return await Future.delayed(Duration(seconds: 2),(){
//     List<dynamic> data = jsonDecode(jsonString);
//     List<User> users = data.map((data) => User.fromJson(data)).toString();
//     List<User> imagesList = jsonString.map((i) => Image.fromJson(i)).toList();
//     return users;
//   });
// }




  Future<void> _screenMassege(BuildContext context) async {
    var response = await http.post(Uri.http('195.19.114.66:8888'),
        headers: {'Accept':'application/json'},
        body: "{\"RequestType\":\"GetDialogsList\",\"Login\":\"${widget._user.username}\",\"Password\": \"${widget._user.password}\"}"
    );
    print(response.body);
    //Коды ответа: 200 успех,400 неправильно составлен запрос, 418 неправильный логин/пароль
    if(response.statusCode==200) {
      Map<String, dynamic> jsonmp=jsonDecode(response.body);
      List dynamiclist = jsonmp['Logins'];
      List<String> Logins = dynamiclist.cast<String>();
      dynamiclist = jsonmp['Unread'];
      final List<int> Unread=dynamiclist.cast<int>();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            Scaffold(
              body: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  backgroundColor: Color.fromRGBO(254, 240, 220, 10),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text('Переписки'),
                    centerTitle: true,
                    backgroundColor: Colors.deepPurpleAccent,
                    toolbarHeight: 25,
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Container(
                        child: Drawer(
                          width: 400,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                                return MessageWithPeople(widget._user,Logins[index],Unread[index]);
                            },
                            itemCount: Logins.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),



      ));
    }
  }

}