 import 'package:flutter/material.dart';
import 'package:project_app/input/input.dart';

import '../home/home.dart';


class PanelMenu extends StatefulWidget{
  @override
  State<PanelMenu> createState() {
    return new _PanelState();
  }

}


class _PanelState extends State<PanelMenu>{

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader (
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
              accountName: Text('Мистер Твистер'),
              accountEmail: Text("home@dartflutter.ru"),
              currentAccountPicture:
              CircleAvatar(backgroundImage: AssetImage('assets/I.jpg'), radius: 30,),
            ),
          ),
          new ListTile(
              title: new Text("О себе"),
              leading: Icon(Icons.account_box),
              onTap: (){}
          ),
          new ListTile(
              title: new Text("Выйти"),
              leading: Icon(Icons.output),
              onTap: (){performLogin();}
          )
        ],
      ),
    );
  }
  void performLogin() {
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new Input()));
  }

}

// abstract class menu extends StatelessWidget{
//
//
//   Drawer(
//   child: new ListView(
//   children: <Widget>[
//   new DrawerHeader(
//   margin: EdgeInsets.zero,
//   padding: EdgeInsets.zero,
//   child: UserAccountsDrawerHeader (
//   decoration: BoxDecoration(color: Colors.green),
//   accountName: Text('Мистер Твистер'),
//   accountEmail: Text("home@dartflutter.ru"),
//   currentAccountPicture: Container(
//   decoration: BoxDecoration(
//   shape: BoxShape.rectangle,
//   color: Colors.red,
//   )
//   ),
//   ),
//   ),
//   new ListTile(
//   title: new Text("О себе"),
//   leading: Icon(Icons.account_box),
//   onTap: (){}
//   ),
//   new ListTile(
//   title: new Text("Настройки"),
//   leading: Icon(Icons.settings),
//   onTap: (){}
//   )
//   ],
//   ),
//
//   );
// }