import 'package:ajwah_bloc/ajwah_bloc.dart';

import 'package:flutter_test_myself/utils/ActionTypes.dart';

import '../models/ThemeModel.dart';

class ThemeState extends BaseState<ThemeModel> {
  ThemeState() : super(name: "theme", initialState: ThemeModel.init());

  @override
  Stream<ThemeModel> mapActionToState(ThemeModel state, Action action) async* {
    switch (action.type) {
      case ActionTypes.ChangeTheme:
        yield ThemeModel(action.payload);
        break;
      default:
        yield latestState(this);
    }
  }
}
