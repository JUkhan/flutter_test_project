import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/states/AjwahBlocFormState.dart';

class AjwahBlocTextField extends StatefulWidget {
  final String fieldName;
  final bool obscureText;
  final String label;
  Store store;
  String formName;
  AjwahBlocTextField({
    Key key,
    @required this.fieldName,
    @required this.label,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _AjwahBlocTextFieldState createState() => _AjwahBlocTextFieldState();
}

class _AjwahBlocTextFieldState extends State<AjwahBlocTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _sendValue('');
  }

  void _sendValue(String value) {
    widget.store.dispatcH(
      widget.formName + ABFormActionTypes.SetFieldValue,
      {
        'fieldName': widget.fieldName,
        'fieldValue': value,
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextField(
          controller: _controller,
          obscureText: widget.obscureText,
          onChanged: _sendValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.label,
          )),
    );
  }
}
