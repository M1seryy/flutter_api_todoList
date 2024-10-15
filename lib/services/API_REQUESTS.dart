import 'dart:convert';

import 'package:todo_app/model/postModel.dart';
import 'package:todo_app/model/todoModel.dart';
import 'package:http/http.dart' as http;

Future<List<todoModel>> fetchTodo() async {
  final response = await http
      .get(Uri.parse('https://669eba089a1bda3680076f3f.mockapi.io/todo'));
  final json = jsonDecode(response.body);
  final listJson = (json as List<dynamic>).toList();
  final transformedListOfTodoes = listJson
      .map((todoItem) => todoModel(
          id: todoItem['id'],
          title: todoItem['title'],
          isDone: todoItem['isDone']))
      .toList();
  return transformedListOfTodoes;
}

Future<http.Response> addNewTodo(bodyData) async {
  final responce = await http.post(
    Uri.parse('https://669eba089a1bda3680076f3f.mockapi.io/todo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': "10",
      "title": "POST_API_DATA",
      "isDone": "false"
    }),
  );
  print('Sended data is: $bodyData');
  return responce;
}

//------------------POOOOSSSSSTTTTTTSSSSSS---------------

Future<List<Post>> fetchPost() async {
  print('It has begun');
  const url = 'https://jsonplaceholder.typicode.com/posts';
  final uri = Uri.parse(url);
  final responce = await http.get(uri);
  final json = jsonDecode(responce.body);
  final listJson = (json as List<dynamic>).toList();
  final transformed = listJson
      .map((element) => Post(
          userId: element['userId'],
          id: element['id'],
          title: element['title'],
          body: element['body']))
      .toList();
  return transformed;
}
