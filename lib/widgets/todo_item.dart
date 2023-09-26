import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';

import 'package:todoapp/model/modeltodo.dart';

class todoitem extends StatelessWidget {
  //------------------------------------------------
  final ToDo todo;
  final ontodochanged;
  final ondeleteitem;
  //-----------------------------------------
  todoitem(
      {Key? key,
      required this.todo,
      required this.ondeleteitem,
      required this.ontodochanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
          onTap: () {
            print('clciked');
            ontodochanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(todo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              )),
          trailing: Container(
              padding: EdgeInsets.all(0),
              // margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  ondeleteitem(todo.id);
                },
              ))),
    );
  }
}
