import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/states/registration.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ajwah_bloc_test/ajwah_bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/states/TodoState.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:flutter_test_myself/utils/AsyncData.dart';
import 'package:mockito/mockito.dart';

import 'shared_pref_mock.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  AjwahStore store;
  MockClient client;
  setUpAll(() {
    setSharedPrefMockData();
    client = MockClient();
    GetIt.I.registerSingleton<TodoApi>(TodoApi.withMocks(client: client));
    store = createStore();
    GetIt.I.registerSingleton<AjwahStore>(store);
    registration();
  });
  tearDownAll(() {
    store.dispose();
  });
  ajwahTest<TodoModel>(
      "emits a loading state then result state when api call succeeds",
      build: () {
        when(client.get(baseUrl + 'todos/2')).thenAnswer((_) async =>
            http.Response(
                '{"id":2,"userId":1,"title":"learn ajwah_bloc","completed":false}',
                202));

        return store.select("todo");
      },
      skip: 1,
      log: (arr) {
        print(arr[1].todo.data.title);
      },
      act: () => store.dispatch(Action(type: ActionTypes.FetchTodo)),
      expect: [isA<TodoModel>(), isA<TodoModel>()],
      verify: (arr) {
        expect(arr[0].todo.asyncStatus, AsyncStatus.Loading);
        expect(arr[1].todo.asyncStatus, AsyncStatus.Loaded);
        expect(arr[1].todo.data.title, "learn ajwah_bloc");
      });
}
