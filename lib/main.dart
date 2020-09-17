import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/pages/AnimOne.dart';
import 'package:flutter_test_myself/pages/HomePage.dart';
import 'package:flutter_test_myself/pages/LoginPage.dart';
import 'package:flutter_test_myself/pages/SettingPage.dart';
import 'package:flutter_test_myself/pages/SignupPage.dart';
import 'package:flutter_test_myself/pages/TodoPage.dart';
import 'package:flutter_test_myself/pages/WelcomePage.dart';
import 'package:flutter_test_myself/services/todoApi.dart';
import 'package:flutter_test_myself/states/registration.dart';
import 'package:flutter_test_myself/widgets/StreamConsumer.dart';
import 'package:get_it/get_it.dart';
import 'models/ThemeModel.dart';

void main() {
  GetIt.I.registerSingleton<TodoApi>(TodoApi());
  var store = createStore();
  store.exportState().listen((arr) {
    print(arr[0].type);
    print(arr[1]);
  });
  GetIt.I.registerSingleton<AjwahStore>(store);
  registration();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamConsumer<ThemeModel>(
        listener: (context, state) {
          print('Theme changed of primary color: ${state.primarySwatch}');
        },
        stream: GetIt.I<AjwahStore>().select<ThemeModel>("theme"),
        initialData: ThemeModel.init(),
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: state.primarySwatch.value == 4278190080
                  ? ThemeData.dark().copyWith(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      primaryColor: Colors.grey[800],
                      accentColor: Colors.white60,
                      brightness: Brightness.dark,
                      backgroundColor: Colors.grey[800],
                    )
                  : ThemeData(
                      primarySwatch: state.primarySwatch,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
              initialRoute: "/",
              routes: {
                "/": (_) => HomePage(),
                "/settings": (_) => SettingPage(),
                "/anim1": (_) => AnimOne(),
                "/login": (_) => LoginPage(),
                "/signup": (_) => SignUpPage(),
                "/welcome": (_) => WelcomePage(),
                "/todo": (_) => TodoPage()
              });
        });
  }
}
