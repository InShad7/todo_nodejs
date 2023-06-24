import 'package:flutter/material.dart';
import 'package:todo_nodejs/controller/conroller.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField({super.key, this.isTitle = false});
  final isTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autofocus: true,
        cursorColor: Colors.black,
        controller: isTitle ? titleController : contentController,
        maxLines: null,
        maxLength: isTitle ? 50 : 300,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: isTitle ? 'Title' : 'What\'s happening?',
          hintStyle: const TextStyle(color: grey, fontSize: 18),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        style: const TextStyle(color: black, fontSize: 18),
      ),
    );
  }
}
