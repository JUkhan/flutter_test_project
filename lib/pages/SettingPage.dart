import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/states/ThemeState.dart';
import 'package:flutter_test_myself/widgets/ColorThemeWidget.dart';
import 'package:flutter_test_myself/widgets/LeftMenu.dart';
import 'package:flutter_test_myself/models/ThemeModel.dart';
import 'package:flutter_test_myself/utils/ActionTypes.dart';
import 'package:flutter_test_myself/widgets/StreamConsumer.dart';
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
        child: StreamConsumer<ThemeModel>(
            stream: GetIt.I<AjwahStore>().select('theme'),
            initialData: ThemeModel.init(),
            builder: (context, state) {
              return ColorThemeWidget(
                onColorChange: (color) {
                  GetIt.I<AjwahStore>()
                      .dispatch(ChangeThemeAction(color: color));
                },
                selectedColor: state.primarySwatch,
              );
            }),
      ),
    );
  }
}
