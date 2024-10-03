import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/service/cep_service.dart';


class CEPRepository {
  final CEPService cepService;

  CEPRepository(this.cepService);

  Future<CEPModel> getCEP(String cep) {
    return cepService.getCEP(cep);
  }
}
