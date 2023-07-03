import 'package:flutter/material.dart';
import 'package:todo_nodejs/view/dashboard_screen/dashboard_screen.dart';
import 'package:todo_nodejs/view/utils/utils.dart';

void alertBox({
  context,
  delete = false,
  id,
  delFun,
}) {
  showModalBottomSheet(
    backgroundColor: grey2,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(18),
      ),
    ),
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kHeight,
        SizedBox(
          width: 400,
          height: 70,
          child: TextButton(
            onPressed: () async {
              if (delete == true) {
                delFun(id);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              delete ? 'Delete' : 'Logout',
              style: const TextStyle(color: teal, fontSize: 18),
            ),
          ),
        ),
        const Divider(indent: 60, endIndent: 60),
        SizedBox(
          height: 65,
          width: 400,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: red, fontSize: 18),
            ),
          ),
        ),
        kHeight,
      ],
    ),
  );
}
