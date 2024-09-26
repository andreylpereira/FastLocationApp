import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_repository.dart';
import 'package:fast_location_app/src/modules/home/store/cep_store.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';

class CEPController {
  final CEPRepository cepRepository;
  final CEPStore cepStore;

  CEPController(this.cepRepository, this.cepStore);
  
  Future<void> loadCEPs() async {
    await cepStore.loadCEPs();
  }

  Future<void> saveCEP(CEPModel cep) async {
    await cepStore.saveCEP(cep);
  }

  Future<CEPModel> buscarCEP(String cep) async {
    return await cepRepository.buscarCEP(cep);
  }

  Future<void> openMaps(CEPModel cepModel) async {
    String address = '${cepModel.logradouro}, ${cepModel.localidade}, ${cepModel.uf}';
    List<Location> locations = await locationFromAddress(address);

    final availableMaps = await MapLauncher.installedMaps;

    final googleMaps = availableMaps.firstWhere(
      (map) => map.mapName.toLowerCase() == "google maps",
      orElse: () => throw Exception('Google Maps não está disponível'),
    );

    await googleMaps.showMarker(
      coords: Coords(locations.first.latitude, locations.first.longitude),
      title: "Localização do CEP: ${cepModel.cep}",
    );
  }
}
