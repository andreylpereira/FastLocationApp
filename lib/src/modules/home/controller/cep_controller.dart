import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/store/cep_store.dart';

class CEPController {
  final CEPStore cepStore;

  CEPController(this.cepStore);

  Future<void> loadCEPs() async {
    await cepStore.loadCEPs();
  }

  Future<void> saveCEP(CEPModel cep) async {
    await cepStore.saveCEP(cep);
  }
}
