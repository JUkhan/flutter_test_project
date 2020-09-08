// "userId": 1,
// "id": 1,
// "title": "delectus aut autem",
// "completed": false

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  Todo({this.userId, this.id, this.title, this.completed});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'title': title, 'completed': completed};
  }
}
