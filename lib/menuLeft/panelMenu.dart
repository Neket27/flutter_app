 import 'package:flutter/material.dart';
import 'package:project_app/input/input.dart';
import 'package:project_app/menuLeft/changingUserData.dart';

import '../home/home.dart';
import '../models/user.dart';


class PanelMenu extends StatefulWidget{
  User _user;

  PanelMenu(this._user, {super.key});

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
              accountName: Text(widget._user.firstName!+' '+widget._user.lastName!),
              accountEmail: Text("@"+widget._user.username),
              currentAccountPicture:
              CircleAvatar(backgroundImage: AssetImage(widget._user.avatar!), radius: 30,),
            ),
          ),
          new ListTile(
              title: new Text("О себе"),
              leading: Icon(Icons.account_box),
              onTap: (){_screenChangingUserData();}
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





  void _screenChangingUserData() {
    Navigator.push(
        _context,
        new MaterialPageRoute(
            builder: (context) => new ChangingUserData()));
  }



}

