import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/services/cep_service.dart';

class CEPRepository {
  final CEPService cepService;

  CEPRepository(this.cepService);

  Future<CEPModel> buscarCEP(String cep) {
    return cepService.buscarCEP(cep);
  }
}
