import 'package:ajwah_bloc/ajwah_bloc.dart';

Action getAction(String actionType, [dynamic payload]) {
  return Action(type: actionType, payload: payload);
}

enum AsyncStatus { Loading, Loaded, Error }

class AsyncData<T> {
  final T data;
  final AsyncStatus asyncStatus;
  final String error;
  AsyncData({this.data, this.asyncStatus, this.error});

  AsyncData.loaded(T data)
      : this(
          data: data,
          asyncStatus: AsyncStatus.Loaded,
          error: null,
        );

  AsyncData.error(String message)
      : this(
          data: null,
          asyncStatus: AsyncStatus.Error,
          error: message,
        );
  AsyncData.loading()
      : this(
          data: null,
          asyncStatus: AsyncStatus.Loading,
          error: null,
        );
}

String baseUrl = "https://jsonplaceholder.typicode.com/";
