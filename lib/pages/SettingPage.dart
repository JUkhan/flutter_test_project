import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/widgets/ColorThemeWidget.dart';
import 'package:flutter_test_myself/widgets/LeftMenu.dart';
import 'package:flutter_test_myself/models/ThemeModel.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:get_it/get_it.dart';

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
            stream: GetIt.I<Store>().select('theme'),
            initialData: ThemeModel.init(),
            builder: (context, snapshot) {
              return ColorThemeWidget(
                onColorChange: (color) {
                  GetIt.I<Store>().dispatcH(ActionTypes.ChangeTheme, color);
                },
                selectedColor: snapshot.data.primarySwatch,
              );
            }),
      ),
    );
  }
}
