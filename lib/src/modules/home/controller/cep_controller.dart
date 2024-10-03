import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_repository.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_local_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';



part 'cep_controller.g.dart';

class CEPController = _CEPController with _$CEPController;

abstract class _CEPController with Store {
  final CEPRepository cepRepository;
  final CEPLocalRepository cepLocalRepository;

  _CEPController(this.cepRepository, this.cepLocalRepository);

  @observable
  ObservableList<CEPModel> ceps = ObservableList<CEPModel>();

  @action
  Future<void> loadCEPs() async {
    await cepLocalRepository.loadCEPs();
    ceps.clear();
    ceps.addAll(cepLocalRepository.cepList);
  }

  @action
  Future<void> saveCEP(CEPModel cep) async {
    await cepLocalRepository.saveCEP(cep);
    ceps.add(cep);
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
