import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_local_repository.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryController with _$HistoryController;

abstract class _HistoryController with Store {
  final CEPLocalRepository cepLocalRepository;

  _HistoryController(this.cepLocalRepository);

  @observable
  ObservableList<CEPModel> ceps = ObservableList<CEPModel>();

  @action
  Future<void> loadCEPs() async {
    ceps.clear();
    await cepLocalRepository.loadCEPs();
    ceps.addAll(cepLocalRepository.cepList);
  }
}
