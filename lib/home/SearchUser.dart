import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/models/SearchedUser.dart';
class SearchUser extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [ // TODO пользователи, которые были найдены по неполному или полному нику
  ];
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
          title: Text(result),
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
          title: Text(result),
        );
      },
    );
  }
}