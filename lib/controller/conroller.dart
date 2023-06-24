import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_nodejs/controller/config.dart';
import 'package:todo_nodejs/view/dashboard_screen/dashboard_screen.dart';
import 'package:todo_nodejs/view/login_screen/login_screen.dart';

TextEditingController nameController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();

void registerUser(context) async {
  if (userNameController.text.isNotEmpty &&
      passwordController.text.isNotEmpty) {
    var regBody = {
      "email": userNameController.text,
      "password": passwordController.text
    };

    var response = await http.post(
      Uri.parse(url + 'register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    print(response.body);

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);
    if (jsonResponse['status']) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      print("SomeThing Went Wrong");
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter valid username and password')));
  }
}

void loginUser(context) async {
  if (userNameController.text.isNotEmpty &&
      passwordController.text.isNotEmpty) {
    var regBody = {
      "email": userNameController.text,
      "password": passwordController.text
    };

    var response = await http.post(
      Uri.parse(url + 'login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    print(response.body);

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse['status']);

    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(token: myToken),
        ),
      );
    } else {
      print("SomeThing Went Wrong");
    }
  }
}
