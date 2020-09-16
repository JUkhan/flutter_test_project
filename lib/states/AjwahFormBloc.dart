import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/states/AjwahBlocFormState.dart';

abstract class AjwahFormBloc {
  final Store store;
  final String formName;
  AjwahFormBloc({@required this.store, @required this.formName});
  void emitSuccess() {
    store.dispatcH(formName + ABFormActionTypes.Success);
  }

  void emitFailure() {
    store.dispatcH(formName + ABFormActionTypes.Failure);
  }

  void onSubmitting(Map<String, dynamic> fieldMap);
}
