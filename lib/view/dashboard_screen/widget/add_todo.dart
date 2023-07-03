import 'package:flutter/material.dart';
import 'package:todo_nodejs/controller/conroller.dart';
import 'package:todo_nodejs/view/dashboard_screen/widget/todo_texf_field.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key, this.addTodo});
  final addTodo;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: white,
              child: Column(
                children: [
                  kHeight30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          titleController.clear();
                          contentController.clear();
                        },
                        icon: const Icon(Icons.close),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                        ),
                        onPressed: () {
                          addTodo();

                          // add
                          //     ? tweetModel.addTweet(context)
                          //     : tweetModel.editTweet(context, data);
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  TodoTextField(isTitle: true),
                  TodoTextField()
                ],
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
