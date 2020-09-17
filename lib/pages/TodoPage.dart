import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/widgets/LeftMenu.dart';
import 'package:flutter_test_myself/states/TodoState.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';
import 'package:flutter_test_myself/widgets/StreamConsumer.dart';
import 'package:get_it/get_it.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Page"),
      ),
      drawer: LeftMenu(),
      body: Container(
        alignment: Alignment.center,
        child: StreamConsumer<TodoModel>(
          stream: GetIt.I<AjwahStore>().select('todo'),
          initialData: TodoModel.init(),
          builder: (_, state) {
            if (state.todo.asyncStatus == AsyncStatus.Loading) {
              return CircularProgressIndicator();
            } else if (state.todo.asyncStatus == AsyncStatus.Error) {
              return Text(
                state.todo.error,
                style: new TextStyle(
                  color: Colors.red[300],
                ),
              );
            }
            return Container(
              child: Text(state.todo.data.title),
            );
          },
        ),
      ),
    );
  }
}
