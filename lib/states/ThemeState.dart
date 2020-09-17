import 'dart:ui';

import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/services/appService.dart';

import 'package:flutter_test_myself/utils/ActionTypes.dart';

import '../models/ThemeModel.dart';

class ChangeThemeAction extends Action {
  final Color color;
  ChangeThemeAction({this.color});
}

void registerThemeState(AjwahStore store) => store.registerState<ThemeModel>(
      stateName: 'theme',
      initialState: ThemeModel.init(),
      mapActionToState: (state, action, emit) async {
        if (action is ChangeThemeAction) {
          emit(ThemeModel(action.color));
          AppService.writeBySharedPref("theme", action.color.value);
        } else if (action.type == 'registerState(theme)') {
          var colorVal = await AppService.readBySharedPref("theme", 0);
          if (colorVal != 0)
            emit(ThemeModel(materialColors
                .firstWhere((element) => element.value == colorVal)));
        }
      },
    );
