import 'package:flutter/material.dart';
import 'package:flutter_test_myself/components/CustomButtonWidget.dart';
import 'package:flutter_test_myself/components/LeftMenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: LeftMenu(),
      body: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: CustomButtonWidget(
          title: "Click Me",
          onPressHandler: () {
            print("welcome");
          },
        ),
      ),
    );
  }
}
