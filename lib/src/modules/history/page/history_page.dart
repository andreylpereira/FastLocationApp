import 'package:fast_location_app/src/shared/components/list_widget_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:fast_location_app/src/shared/storage/cep_store.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/history/controller/history_controller.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_local_repository.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  late final HistoryController historyController;

  @override
  void initState() {
    super.initState();
    final Box<String> box = Hive.box<String>('cepBox');
    final cepStore = CEPStore(box);
    final cepLocalRepository = CEPLocalRepository(cepStore);
    historyController = HistoryController(cepLocalRepository);
    historyController.loadCEPs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          'Histórico de Endereços',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.backgroundColor),
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_) => ListWidgetHistory(history: historyController.ceps),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
