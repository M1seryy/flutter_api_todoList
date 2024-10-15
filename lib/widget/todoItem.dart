import 'package:flutter/material.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/model/todoModel.dart';

class TodoItem extends StatelessWidget {
  final onTodoChnage;
  final todoModel todoo;
  final onDeleteTodo;

  const TodoItem({
    super.key,
    required this.todoo,
    this.onTodoChnage,
    this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            onTap: () {
              onTodoChnage(todoo);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            tileColor: Colors.white,
            leading: todoo.isDone
                ? const Icon(
                    Icons.check_box,
                    color: tdBlue,
                  )
                : const Icon(Icons.check_box_outline_blank),
            title: Text(
              todoo.title,
              style: TextStyle(
                  fontSize: 16,
                  color: tdBlack,
                  decoration: todoo.isDone ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: tdRed,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    onDeleteTodo(todoo);
                  },
                  icon: const Icon(Icons.delete),
                  iconSize: 18,
                )),
          ),
        ),
      ],
    );
  }
}
