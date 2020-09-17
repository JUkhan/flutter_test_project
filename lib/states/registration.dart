import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/states/ThemeState.dart';
import 'package:flutter_test_myself/states/TodoState.dart';
import 'package:get_it/get_it.dart';

void registration() {
  var store = GetIt.I<AjwahStore>();
  var api = GetIt.I<TodoApi>();
  registerTodoState(store, api);
  registerThemeState(store);
}
