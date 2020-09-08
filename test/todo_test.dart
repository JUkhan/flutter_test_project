// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ajwah_bloc_test/ajwah_bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/store/TodoState.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  Store store;
  MockClient client;
  setUpAll(() {
    client = MockClient();
    GetIt.I.registerSingleton<TodoApi>(TodoApi.withMocks(client: client));
    store = createStore(states: [TodoState()], block: true);
  });
  tearDownAll(() {
    store.dispose();
  });
  ajwahTest<TodoModel>(
      "emits a loading state then result state when api call succeeds",
      build: () {
        when(client.get(baseUrl + 'todos/2')).thenAnswer((_) async => http.Response(
            '{"id":2,"userId":1,"title":"test wow its cool, alhumdulilla","completed":false}',
            202));

        return store.select<TodoModel>("todo");
      },
      skip: 1,
      log: (arr) {
        print(arr[1].todo.data.title);
      },
      act: () => store.dispatch(getAction(ActionTypes.FetchTodo)),
      expect: [isA<TodoModel>(), isA<TodoModel>()],
      verify: (arr) {
        expect(arr[0].todo.asyncStatus, AsyncStatus.Loading);
        expect(arr[1].todo.asyncStatus, AsyncStatus.Loaded);
      });
}
