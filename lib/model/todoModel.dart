class todoModel {
  String id;
  String title;
  bool isDone;

  todoModel({required this.id, required this.title, required this.isDone});

  // static List<todoModel> todoList() {
  //   return [
  //     todoModel(id: 1, title: "Some text 1", isDone: false),
  //     todoModel(id: 2, title: "Some text 2", isDone: false),
  //     todoModel(id: 3, title: "Some text 3", isDone: true),
  //     todoModel(id: 4, title: "Some text 4", isDone: false),
  //     todoModel(id: 5, title: "Some text 5", isDone: true),
  //   ];
  // }

  factory todoModel.fromJson(Map<String, dynamic> json) {
    return todoModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
    );
  }
}
