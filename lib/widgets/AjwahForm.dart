import 'dart:async';
import 'package:ajwah_bloc/ajwah_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_myself/states/AjwahBlocFormState.dart';
import 'package:flutter_test_myself/states/AjwahFormBloc.dart';
import 'package:flutter_test_myself/widgets/AjwahBlocTextField.dart';

typedef FormBlocCreateCallback = AjwahFormBloc Function(
  Store store,
  String formName,
);
typedef FormStatusCallback = void Function(
    BuildContext context, AjwahBlocFormModel formModel);

class AjwahForm extends StatefulWidget {
  final String formName;
  final List<Widget> fields;
  final Store store;
  final FormBlocCreateCallback create;
  final FormStatusCallback onSubmitting;
  final FormStatusCallback onSuccess;
  final FormStatusCallback onFailure;
  AjwahForm({
    Key key,
    @required this.formName,
    @required this.store,
    @required this.fields,
    @required this.create,
    this.onSubmitting,
    this.onSuccess,
    this.onFailure,
  }) : super(key: key) {
    for (var item in fields) {
      if (item is AjwahBlocTextField) {
        item.formName = formName;
        item.store = store;
      }
    }
  }

  @override
  _AjwahFormState createState() => _AjwahFormState();
}

class _AjwahFormState extends State<AjwahForm> {
  AjwahFormBloc _formBloc;
  StreamSubscription _sub;
  @override
  void initState() {
    _formBloc = widget.create(widget.store, widget.formName);
    /* widget.store.addEffect(
      (action$, store$) => action$
          .whereType(widget.formName)
          .withLatestFrom<AjwahBlocFormModel, AjwahBlocFormModel>(
              store$.select<AjwahBlocFormModel>(widget.formName), (a, b) => b)
          .map((event) {
        _formBloc.onSubmitting(event.fields);
        return ajwah.Action(
            type: widget.formName + "_submitting", payload: event);
      }),
      effectKey: widget.formName,
    );*/
    _sub = widget.store
        .select<AjwahBlocFormModel>(widget.formName)
        .listen((event) {
      switch (event.status) {
        case AjwahFormStatus.Loading:
          _formBloc.onSubmitting(event.fields);
          widget.onSubmitting?.call(context, event);
          break;
        case AjwahFormStatus.Success:
          widget.onSuccess?.call(context, event);
          break;
        case AjwahFormStatus.Failure:
          widget.onFailure?.call(context, event);
          break;
        default:
      }
    });
    widget.store.addState(AjwahBlocFormState(formName: widget.formName));
    super.initState();
  }

  @override
  void dispose() {
    widget.store.removeStateByStateName(widget.formName);
    // ..removeEffectsByKey(widget.formName);
    if (_sub != null) {
      _sub.cancel();
      _sub = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.fields,
      ),
    );
  }
}
