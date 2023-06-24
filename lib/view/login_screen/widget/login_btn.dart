import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_nodejs/controller/conroller.dart';
import 'package:todo_nodejs/view/login_screen/login_screen.dart';
import 'package:todo_nodejs/view/signup_screen/signup_screen.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key, this.signup = false});
  final signup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                if (signup
                    ? !SignUpformKey.currentState!.validate()
                    : !formKey.currentState!.validate()) {
                  Fluttertoast.showToast(
                      msg: 'Enter a valid Email and Password');
                } else {
                  signup ? registerUser(context) : loginUser(context);
                }
              },
              child: Text(
                signup ? 'Sign Up' : 'Sign In',
                style: const TextStyle(fontSize: 28, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
