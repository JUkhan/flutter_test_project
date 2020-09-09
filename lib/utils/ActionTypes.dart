import 'package:flutter/material.dart';

abstract class ActionTypes {
  static const ChangeTheme = "change_theme";
  static const FetchTodo = "FetchTodo";
  static const FetchTodos = "FetchTodos";
  static const SaveTodo = "SaveTodo";
  static const UpdateTodo = "UpdateTodo";
}

const List<Color> materialColors = const <Color>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black
];
