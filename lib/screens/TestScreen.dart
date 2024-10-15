import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/model/postModel.dart';
import 'package:todo_app/services/API_REQUESTS.dart';
import 'package:http/http.dart' as http;

class Testscreen extends StatefulWidget {
  Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  List<Post> listOfPosts = [];

  @override
  void initState() {
    checkPosts();
  }

  void checkPosts() async {
    final allPosts = await fetchPost();
    setState(() {
      listOfPosts = allPosts;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: listOfPosts.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(listOfPosts[index].title));
            }),
      ),
    );
  }
}
