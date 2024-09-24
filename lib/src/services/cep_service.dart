import 'package:fast_location_app/src/modules/home/model/cep_model.dart';

import '../http/http_client.dart';

class CEPService {
  final HttpClient httpClient;

  CEPService(this.httpClient);

  Future<CEPModel> buscarCEP(String cep) async {
    try {
      final response = await httpClient.dio.get('$cep/json/');
      return CEPModel.fromJson(response.data);
    } catch (e) {
      print('Erro ao buscar CEP: $e');
      return CEPModel(erro: true);
    }
  }
}
