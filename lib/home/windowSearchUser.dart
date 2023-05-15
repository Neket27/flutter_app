import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/home/SearchUser.dart';
import 'package:project_app/models/user.dart';

class windowSearchUser extends StatefulWidget {

  User _user;

  windowSearchUser(this._user);

  @override
  State<windowSearchUser> createState() => _windowSearchUserState();
}

class _windowSearchUserState extends State<windowSearchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Поик пользователей",
        ),
        actions: [
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
    );
  }
}