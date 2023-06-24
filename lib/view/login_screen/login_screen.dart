import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/controller/conroller.dart';
import 'package:todo_nodejs/view/login_screen/widget/login_btn.dart';
import 'package:todo_nodejs/view/login_screen/widget/main_card.dart';
import 'package:todo_nodejs/view/login_screen/widget/signup_btn.dart';
import 'package:todo_nodejs/view/login_screen/widget/text_field.dart';
import 'package:todo_nodejs/view/signup_screen/signup_screen.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

final formKey = GlobalKey<FormState>();
late SharedPreferences prefs;

void initSharedPref() async {
  prefs = await SharedPreferences.getInstance();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initSharedPref();
    });
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          const SignInText(title: 'Sign In'),
          kHeight20,
          MyTextField(
              title: 'Email',
              icon: Icons.mail,
              myControler: userNameController,
              passChar: false,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Email can\'t be empty';
                }
              }),
          kHeight,
          MyTextField(
              title: 'Password',
              icon: Icons.lock,
              myControler: passwordController,
              passChar: true,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Password can\'t be empty';
                }
              }),
          kHeight30,
          const LoginBtn(),
          kHeight30,
          SignUpTxtBtn(navigateTo: SignUpScreen()),
          kHeight60,
        ]),
      ),
    );
  }
}
