import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'cep_store.g.dart';

class CEPStore = _CEPStore with _$CEPStore;

abstract class _CEPStore with Store {
  final Box<String> box;

  _CEPStore(this.box);

  @observable
  ObservableList<CEPModel> cepList = ObservableList<CEPModel>();

  @action
  Future<void> loadCEPs() async {
    cepList.clear();
    final storedListJson = box.get('cepList');
    if (storedListJson != null) {
      final List<dynamic> storedList = jsonDecode(storedListJson);
      cepList.addAll(storedList.map((e) => CEPModel.fromJson(e)).toList());
    }
  }

  @action
  Future<void> saveCEP(CEPModel cep) async {
    cepList.add(cep);
    await box.put('cepList', jsonEncode(cepList.map((e) => e.toJson()).toList()));
  }

}
