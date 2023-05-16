import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/models/DialogListElm.dart';
import 'package:project_app/models/SearchedUser.dart';
import 'package:project_app/home/home.dart';
import '../models/user.dart';
class SearchUser extends SearchDelegate {

   User _user;
   HomeState st;
  SearchUser(this._user,this.st);

  // Demo list to show querying
 late List<SearchedUser> matchQuery=[];
  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    getData();
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].FirstName+" "+matchQuery[index].LastName;
        return ListTile(
          title: MaterialButton(onPressed: () async {
            print("User_LOgin=${_user.username}");
          var response =await  http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
              body:  '{"RequestType":"CreateDialog","Login":"${_user.username}","Password": "${_user.password}","LoginRcv":"${matchQuery[index].Login}"}'
          );
          if(response.statusCode==200) {
            st.getData();
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(""),
                content: Text('Диалог успешно создан'),
              ),
            );
          }
          },
          child: Text(result),),
        );
      },
    );
  }
 void getData ()async{
    print(query);
    var response =await  http.get(Uri.parse("http://195.19.114.66:8888/?RequestData=SearchUser&Querry=${query}" ));
    final jsonResponse = json.decode(response.body);
    List<dynamic> q = jsonResponse['Searched'];
     matchQuery = q.map((dynamic item) => SearchedUser.fromJson(item)).toList();
  }
  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
   getData();
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index].FirstName+" "+matchQuery[index].LastName;
        return ListTile(
          title: MaterialButton(onPressed: () async {
            print("User_LOgin=${_user.username}");
            var response =await  http.post(Uri.http('195.19.114.66:8888', 'whatsit/create'),
                body:  '{"RequestType":"CreateDialog","Login":"${_user.username}","Password": "${_user.password}","LoginRcv":"${matchQuery[index].Login}"}'
            );
            if(response.statusCode==200) {
              st.getData();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(""),
                  content: Text('Диалог успешно создан'),
                ),
              );
            }
          },
            child: Text(result),),
        );
      },
    );
  }
}