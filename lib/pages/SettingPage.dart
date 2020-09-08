import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/components/ColorThemeWidget.dart';
import 'package:flutter_test_myself/components/LeftMenu.dart';
import 'package:flutter_test_myself/models/ThemeModel.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: LeftMenu(),
      body: Container(
        alignment: Alignment.center,
        child: StreamBuilder<ThemeModel>(
            stream: select('theme'),
            initialData: ThemeModel.init(),
            builder: (context, snapshot) {
              return ColorThemeWidget(
                onColorChange: (color) {
                  dispatch(ActionTypes.ChangeTheme, color);
                },
                selectedColor: snapshot.data.primarySwatch,
              );
            }),
      ),
    );
  }
}