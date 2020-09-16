import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter_test_myself/services/appService.dart';

import 'package:flutter_test_myself/utils/ActionTypes.dart';

import '../models/ThemeModel.dart';

class ThemeState extends StateBase<ThemeModel> {
  ThemeState() : super(name: "theme", initialState: ThemeModel.init());

  @override
  Stream<ThemeModel> mapActionToState(
      ThemeModel state, Action action, Store store) async* {
    switch (action.type) {
      case ActionTypes.ChangeTheme:
        yield ThemeModel(action.payload);
        AppService.writeBySharedPref("theme", action.payload.value);
        break;
      default:
        yield getState(store);
        var colorVal = await AppService.readBySharedPref("theme", 0);
        if (colorVal != 0)
          yield ThemeModel(materialColors
              .firstWhere((element) => element.value == colorVal));
        break;
    }
  }
}
