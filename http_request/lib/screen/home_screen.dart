import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_request/model/todo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<Todo> todos = [];

  Future fetchTodo() async {
    http.Response request = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/todos",
      ),
    );
    print(request);   
    setState(() {
          todos = (jsonDecode(request.body) as List)
          .map(
            (json)=> Todo. fromJson(json) , 
          )
          .toList();
        });
  }

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Container( 
      child: ListView(
        children: todos
        .map(
          (item) => ListTile(
            title: Text(
              item.title,
            ),
            subtitle: item.completed ? Text("แล้วละนะ") : Text("ยังไม่แล้วนะ"),
          ),
          )
          .toList(),
       ) 
      ),
    );
  }
}
