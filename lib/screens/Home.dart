import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:todo_app/services/API_REQUESTS.dart';
import 'package:todo_app/widget/todoItem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<todoModel> apiTodo = [];

  @override
  void initState() {
    getTodoes();

    // _foundList = apiTodoList;
    super.initState();
  }

  Future<void> getTodoes() async {
    final responce = await fetchTodo();
    print(responce);
    setState(() {
      apiTodo = responce;
    });
  }

  List<todoModel> _foundList = [];
  final _todoController = TextEditingController();

  void onTodoChnageHandler(todoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void onTodoDeleteHandler(todoModel todo) {
    setState(() {
      apiTodo.removeWhere((item) => item.id == todo.id);
    });
  }

  void addTodoItem(String todoTitle) {
    var intValue = Random().nextInt(10); // Value is >= 0 and < 10.
    intValue = Random().nextInt(100) + 50; // Value is >= 50 and < 150.
    setState(() {
      apiTodo.add(todoModel(
          id: (intValue).toString(), title: todoTitle, isDone: false));
    });
    _todoController.clear();
    Map data = {
      'id': (intValue).toString(),
      'title': todoTitle,
      'isDone': 'false',
    };
    addNewTodo(data);
  }

  void _onFilterHandler(String searchWord) {
    print(searchWord);
    List<todoModel> result = [];
    if (searchWord.isEmpty) {
      result = apiTodo;
    } else {
      result = apiTodo
          .where((item) =>
              item.title.toLowerCase().contains(searchWord.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              size: 30,
              color: tdBlack,
            ),
            Container(
              width: 40,
              height: 40,
              child: const Icon(
                Icons.account_box,
                size: 30,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                _SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          "All todoes",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (todoModel todo in apiTodo)
                        TodoItem(
                            todoo: todo,
                            onTodoChnage: onTodoChnageHandler,
                            onDeleteTodo: onTodoDeleteHandler),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Add a new todo item",
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    addTodoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    elevation: 10,
                  ),
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget _SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _onFilterHandler(value),
        decoration: const InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey),
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 10),
            border: InputBorder.none),
      ),
    );
  }
}
