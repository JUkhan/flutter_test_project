import 'package:flutter_test_myself/models/Todo.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoApi {
  http.Client client;

  TodoApi() {
    client = http.Client();
  }
  TodoApi.withMocks({this.client});

  Future<Todo> fetchTodo(String path) {
    return client
        .get(baseUrl + path)
        .then((response) => json.decode(response.body))
        .then((jsond) => Todo.fromJson(jsond));
  }

  Future<List<Todo>> fetchTodos2(String path) {
    return client
        .get(baseUrl + path)
        .then((response) => json.decode(response.body) as List<dynamic>)
        .then((data) => data.map((e) => Todo.fromJson(e)).toList());
  }

  Future<List<Todo>> fetchTodos(String path) async {
    var todos = List<Todo>();
    var response = await client.get(baseUrl + path);
    print('response:$response');
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var todo in parsed) {
      todos.add(Todo.fromJson(todo));
    }
    return todos;
  }

  Future<Todo> saveTodo(String path, Todo todo) {
    return client
        .post(
          baseUrl + path,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: todo.toJson(),
        )
        .then((response) => json.decode(response.body))
        .then((json) => Todo.fromJson(json));
  }

  Future<Todo> updateTodo(String path, Todo todo) {
    return client
        .put(
          baseUrl + path,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: todo.toJson(),
        )
        .then((response) => json.decode(response.body))
        .then((json) => Todo.fromJson(json));
  }
}
