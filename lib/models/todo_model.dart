class TodoModel {
  String? title;
  int? priority;
  bool? isCompleted;

  TodoModel(
      {required this.title, required this.priority, required this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        title: json["title"],
        priority: json["priority"],
        isCompleted: json["isCompleted"]);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};

    data["title"] = title;
    data["priority"] = priority;
    data["isCompleted"] = isCompleted;
    return data;

}
}

