import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/view/dashboard_screen/dashboard_screen.dart';
import 'package:todo_nodejs/view/login_screen/login_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefer = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefer.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});
  final token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: (JwtDecoder.isExpired(token) == false)
          ? DashboardScreen(token: token)
          : LoginScreen(),
    );
  }
}
