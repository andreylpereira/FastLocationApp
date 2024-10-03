// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CEPController on _CEPController, Store {
  late final _$cepsAtom = Atom(name: '_CEPController.ceps', context: context);

  @override
  ObservableList<CEPModel> get ceps {
    _$cepsAtom.reportRead();
    return super.ceps;
  }

  @override
  set ceps(ObservableList<CEPModel> value) {
    _$cepsAtom.reportWrite(value, super.ceps, () {
      super.ceps = value;
    });
  }

  late final _$loadCEPsAsyncAction =
      AsyncAction('_CEPController.loadCEPs', context: context);

  @override
  Future<void> loadCEPs() {
    return _$loadCEPsAsyncAction.run(() => super.loadCEPs());
  }

  late final _$saveCEPAsyncAction =
      AsyncAction('_CEPController.saveCEP', context: context);

  @override
  Future<void> saveCEP(CEPModel cep) {
    return _$saveCEPAsyncAction.run(() => super.saveCEP(cep));
  }

  @override
  String toString() {
    return '''
ceps: ${ceps}
    ''';
  }
}
