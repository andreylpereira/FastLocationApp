import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/shared/storage/cep_store.dart';
import 'package:mobx/mobx.dart';

class CEPLocalRepository with Store {
  final CEPStore cepStore;

  CEPLocalRepository(this.cepStore);

  @observable
  ObservableList<CEPModel> cepList = ObservableList<CEPModel>();

  @action
  Future<void> loadCEPs() async {
    await cepStore.loadCEPs();
    cepList.clear();
    cepList.addAll(cepStore.cepList);
  }

  @action
  Future<void> saveCEP(CEPModel cep) async {
    await cepStore.saveCEP(cep); 
  }
}
