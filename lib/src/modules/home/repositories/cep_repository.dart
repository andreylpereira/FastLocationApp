import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/services/cep_service.dart';

class CEPRepository {
  final CEPService _cepService;

  CEPRepository(this._cepService);

  Future<CEPModel> buscarCEP(String cep) {
    return _cepService.buscarCEP(cep);
  }
}
