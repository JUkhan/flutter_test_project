import 'package:ajwah_bloc/ajwah_bloc.dart';

enum AjwahFormStatus { Initial, Loading, Success, Failure, Validated }

class AjwahBlocFormModel {
  Map<String, dynamic> fields;
  final AjwahFormStatus status;
  final String message;
  AjwahBlocFormModel({
    this.fields,
    this.status,
    this.message,
  });

  AjwahBlocFormModel copyWith({
    Map<String, dynamic> fields,
    AjwahFormStatus status,
    String message,
  }) {
    return AjwahBlocFormModel(
        fields: fields ?? this.fields,
        status: status ?? this.status,
        message: message ?? this.message);
  }

  AjwahBlocFormModel.init()
      : this(
          fields: Map<String, dynamic>(),
          status: AjwahFormStatus.Initial,
          message: "",
        );
  String toString() =>
      'AjwahBlocFormModel(fields: $fields, status:$status, message:$message)';
  /*@override
  String toString() => 'AjwahBlocFormModel(fields: $fields)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AjwahBlocFormModel && mapEquals(o.fields, fields);
  }

  @override
  int get hashCode => fields.hashCode;*/
}

abstract class ABFormActionTypes {
  static const SetFieldValue = '#ABFormSetFieldValue#';
  static const Success = '#ABFormSuccess#';
  static const Failure = '#ABFormFailure#';
}

class AjwahBlocFormState extends StateBase<AjwahBlocFormModel> {
  final String formName;
  final String setFieldKey;
  final String successKey;
  final String failureKey;
  AjwahBlocFormState({this.formName})
      : setFieldKey = formName + ABFormActionTypes.SetFieldValue,
        successKey = formName + ABFormActionTypes.Success,
        failureKey = formName + ABFormActionTypes.Failure,
        super(name: formName, initialState: AjwahBlocFormModel.init());
  @override
  Stream<AjwahBlocFormModel> mapActionToState(
      AjwahBlocFormModel state, Action action, Store store) async* {
    if (setFieldKey == action.type) {
      state.fields[action.payload['fieldName']] = action.payload['fieldValue'];
      yield state.copyWith(fields: state.fields);
    } else if (successKey == action.type) {
      yield state.copyWith(status: AjwahFormStatus.Success);
    } else if (failureKey == action.type) {
      yield state.copyWith(
          status: AjwahFormStatus.Failure, message: action.payload);
    } else if (formName == action.type) {
      yield state.copyWith(status: AjwahFormStatus.Loading);
    } else
      yield getState(store);
  }
}
