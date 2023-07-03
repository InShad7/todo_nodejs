import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_nodejs/controller/config.dart';
import 'package:todo_nodejs/controller/conroller.dart';
import 'package:todo_nodejs/view/dashboard_screen/widget/add_todo.dart';
import 'package:todo_nodejs/view/dashboard_screen/widget/alert.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, required this.token});
  final token;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

late String userId;

class _DashboardScreenState extends State<DashboardScreen> {
  late String email;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    userId = jwtDecodedToken['_id'];
    getTodoList(userId);
  }

  void addTodo() async {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": titleController.text,
        "desc": contentController.text
      };

      var response = await http.post(
        Uri.parse(url + 'createToDo'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      print(response.body);

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        titleController.clear();
        contentController.clear();
        Navigator.pop(context);
        getTodoList(userId);
        Fluttertoast.showToast(msg: 'Todo added.');
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      Fluttertoast.showToast(msg: 'Fields cant be empty');
    }
  }

  Future<void> getTodoList(userId) async {
    var regBody = {
      "userId": userId,
    };

    try {
      var response = await http.post(
        Uri.parse('http://192.168.188.26:3000/getUserTodoList'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        items = jsonResponse['success'];
        setState(() {});
        print(items);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  void deleteItem(id) async {
    var regBody = {"id": id};

    var response = await http.post(Uri.parse(url + 'deleteTodo'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getTodoList(userId);
      Fluttertoast.showToast(msg: 'deleted.', backgroundColor: red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(email),
      ),
      body: items.isEmpty
          ? const Text('Empty')
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  // height: 75,
                  decoration: BoxDecoration(
                    color: grey2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text('${items[index]['title']}'),
                    subtitle: Text('${items[index]['description']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded),
                      onPressed: () {
                        alertBox(
                          context: context,
                          id: items[index]['_id'],
                          delete: true,
                          delFun: deleteItem,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: AddTodo(addTodo: addTodo),
    );
  }
}
