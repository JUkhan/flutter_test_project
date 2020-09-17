import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/models/Todo.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';

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

void registerTodoState(AjwahStore store, TodoApi api) =>
    store.registerState<TodoModel>(
      stateName: 'todo',
      initialState: TodoModel.init(),
      mapActionToState: (state, action, emit) async {
        switch (action.type) {
          case ActionTypes.FetchTodo:
            emit(state.copyWith(todo: AsyncData.loading()));
            try {
              var data = await api.fetchTodo('todos/2');
              emit(state.copyWith(todo: AsyncData.loaded(data)));
            } catch (ex) {
              emit(state.copyWith(todo: AsyncData.error(ex.toString())));
            }
            break;
          default:
        }
      },
    );
