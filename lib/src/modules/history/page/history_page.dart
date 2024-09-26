import 'package:fast_location_app/src/modules/home/store/cep_store.dart';
import 'package:flutter/material.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location_app/src/shared/components/list_widget_history.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  late final CEPStore cepStore;
  CEPModel? cepModel;

  @override
  void initState() {
    super.initState();
    final Box<String> box = Hive.box<String>('cepBox');
    cepStore = CEPStore(box);
    cepStore.loadCEPs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 220, 220),
        elevation: 0,
        title: Text(
          'Histórico de Endereços',
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 220, 220, 220)),
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Observer(
                builder: (_) => ListWidgetHistory(history: cepStore.cepList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
