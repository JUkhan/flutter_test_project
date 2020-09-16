import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/models/Todo.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';
import 'package:get_it/get_it.dart';

class TodoModel {
  final AsyncData<Todo> todo;
  final AsyncData<List<Todo>> todos;

  TodoModel({
    this.todo,
    this.todos,
  });

  TodoModel copyWith({
    AsyncData<Todo> todo,
    AsyncData<List<Todo>> todos,
  }) {
    return TodoModel(
      todo: todo ?? this.todo,
      todos: todos ?? this.todos,
    );
  }

  TodoModel.init()
      : this(todo: AsyncData.loading(), todos: AsyncData.loading());
}

class TodoState extends StateBase<TodoModel> {
  TodoState() : super(name: "todo", initialState: TodoModel.init());
  var api = GetIt.I<TodoApi>();
  @override
  Stream<TodoModel> mapActionToState(
      TodoModel state, Action action, Store store) async* {
    switch (action.type) {
      case ActionTypes.FetchTodo:
        yield state.copyWith(todo: AsyncData.loading());
        try {
          var data = await api.fetchTodo('todos/2');
          yield state.copyWith(todo: AsyncData.loaded(data));
        } catch (ex) {
          yield state.copyWith(todo: AsyncData.error(ex.toString()));
        }
        break;
      default:
        yield getState(store);
    }
  }
}
