import 'package:flutter/material.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 165),
      child: Column(
        children: [
          const Text(
            'TodoApp.',
            style: TextStyle(
              fontSize: 40,
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          kHeight,
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              color: black,
              // fontWeight: FontWeight.bold,
            ),
          ),
          kHeight20,
          // kHeight20
        ],
      ),
    );
  }
}
