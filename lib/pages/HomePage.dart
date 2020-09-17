import 'package:flutter/material.dart';

import 'package:flutter_test_myself/widgets/CustomButtonWidget.dart';
import 'package:flutter_test_myself/widgets/LeftMenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              /*AjwahForm(
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
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
