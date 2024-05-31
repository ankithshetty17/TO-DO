import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';

class ToDoList extends StatelessWidget {
  final ToDo todo;
  final onhandleToDochange;
  final onToDodelete;
  const ToDoList(
      {Key? key,
      required this.todo,
      required this.onhandleToDochange,
      required this.onToDodelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          onhandleToDochange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          todo.ToDoText!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: Colors.black),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: todo.isDone ? Colors.blue : Colors.grey,
        ),
        trailing: GestureDetector(
          onTap: () {
            onToDodelete(todo.id);
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
