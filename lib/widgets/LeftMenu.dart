import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:get_it/get_it.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
        ),
        ListTile(
          title: Text("Settings"),
          onTap: () {
            Navigator.pushNamed(context, "/settings");
          },
        ),
        ListTile(
          title: Text("Animation one"),
          onTap: () {
            Navigator.pushNamed(context, "/anim1");
          },
        ),
        ListTile(
          title: Text("Login"),
          onTap: () {
            Navigator.pushNamed(context, "/login");
          },
        ),
        ListTile(
          title: Text("Signup"),
          onTap: () {
            Navigator.pushNamed(context, "/signup");
          },
        ),
        ListTile(
          title: Text("Welcome"),
          onTap: () {
            Navigator.pushNamed(context, "/welcome");
          },
        ),
        ListTile(
          title: Text("Todo Page"),
          onTap: () {
            GetIt.I<Store>().dispatch(ActionTypes.FetchTodo);
            Navigator.pushNamed(context, "/todo");
          },
        )
      ],
    ));
  }
}
