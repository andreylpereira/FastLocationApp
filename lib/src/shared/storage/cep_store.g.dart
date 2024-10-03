// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CEPStore on _CEPStore, Store {
  late final _$cepListAtom = Atom(name: '_CEPStore.cepList', context: context);

  @override
  ObservableList<CEPModel> get cepList {
    _$cepListAtom.reportRead();
    return super.cepList;
  }

  @override
  set cepList(ObservableList<CEPModel> value) {
    _$cepListAtom.reportWrite(value, super.cepList, () {
      super.cepList = value;
    });
  }

  late final _$loadCEPsAsyncAction =
      AsyncAction('_CEPStore.loadCEPs', context: context);

  @override
  Future<void> loadCEPs() {
    return _$loadCEPsAsyncAction.run(() => super.loadCEPs());
  }

  late final _$saveCEPAsyncAction =
      AsyncAction('_CEPStore.saveCEP', context: context);

  @override
  Future<void> saveCEP(CEPModel cep) {
    return _$saveCEPAsyncAction.run(() => super.saveCEP(cep));
  }

  @override
  String toString() {
    return '''
cepList: ${cepList}
    ''';
  }
}
