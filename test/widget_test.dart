// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:ajwah_bloc/ajwah_bloc.dart';

import 'package:ajwah_bloc_test/ajwah_bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_myself/models/ThemeModel.dart';
import 'package:flutter_test_myself/states/ThemeState.dart';

import 'package:flutter_test_myself/utils/ActionTypes.dart';

void main() {
  Store store;
  setUpAll(() {
    store = createStore(states: [ThemeState()]);
  });
  tearDownAll(() {
    store.dispose();
  });
  ajwahTest(
    "This is simple ajwah test",
    build: () => store
        .select<ThemeModel>("theme")
        .map((event) => event.primarySwatch.value),
    //act: () => dispatch(ActionTypes.ChangeTheme, Colors.blue),
    expect: [ThemeModel.init().primarySwatch.value],
  );

  ajwahTest(
    "This is another example",
    build: () => store
        .select<ThemeModel>("theme")
        .map((event) => event.primarySwatch.value),
    act: () => store.dispatcH(ActionTypes.ChangeTheme, Colors.blue),
    skip: 1,
    expect: [Colors.blue.value],
  );
}
