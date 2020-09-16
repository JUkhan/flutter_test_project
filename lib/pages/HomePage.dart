import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/states/AjwahFormBloc.dart';
import 'package:flutter_test_myself/widgets/AjwahForm.dart';
import 'package:flutter_test_myself/widgets/AjwahBlocTextField.dart';
import 'package:flutter_test_myself/widgets/CustomButtonWidget.dart';
import 'package:flutter_test_myself/widgets/LeftMenu.dart';
import 'package:flutter_test_myself/widgets/LoadingDialog.dart';
import 'package:get_it/get_it.dart';

class SampleFormLogic extends AjwahFormBloc {
  SampleFormLogic(Store store, String formName)
      : super(store: store, formName: formName);
  @override
  void onSubmitting(Map<String, dynamic> fieldMap) async {
    print(fieldMap);
    await Future<void>.delayed(Duration(seconds: 2));
    emitSuccess();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = GetIt.I<Store>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: LeftMenu(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomButtonWidget(
                title: "Click Me",
                onPressHandler: () {
                  print("welcome");
                },
              ),
              AjwahForm(
                formName: "sample",
                store: _store,
                create: (store, formName) => SampleFormLogic(store, formName),
                onSubmitting: (context, formModel) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, formModel) {
                  LoadingDialog.hide(context);
                },
                onFailure: (context, formModel) {},
                fields: [
                  AjwahBlocTextField(
                    fieldName: "userName",
                    label: "User name",
                  ),
                  AjwahBlocTextField(
                    fieldName: "password",
                    label: "password",
                    obscureText: true,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _store.dispatcH('sample');
                    },
                    child: Text("Login"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
