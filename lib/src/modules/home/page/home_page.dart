import 'package:fast_location_app/src/modules/home/controller/cep_controller.dart';
import 'package:fast_location_app/src/modules/home/store/cep_store.dart';
import 'package:fast_location_app/src/shared/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location_app/src/modules/home/components/card_widget.dart';
import 'package:fast_location_app/src/modules/home/components/home_appbar.dart';
import 'package:fast_location_app/src/shared/components/list_widget_history.dart';
import 'package:fast_location_app/src/modules/home/components/modal_form.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final CEPController cepController; 
  CEPModel? cepModel;

  @override
  void initState() {
    super.initState();
    final Box<String> box = Hive.box<String>('cepBox');
    cepController = CEPController(CEPStore(box)); 
    cepController.loadCEPs(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 220, 220, 220)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Observer(
              builder: (_) {
                return CardWidget(
                  cep: cepModel?.cep,
                  logradouro: cepModel?.logradouro,
                  complemento: cepModel?.complemento,
                  bairro: cepModel?.bairro,
                  localidade: cepModel?.localidade,
                  uf: cepModel?.uf,
                );
              },
            ),
            SizedBox(height: 4.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              onPressed: () async {
                final cepData = await ModalForm.show(context, cepController); 
                if (cepData != null) {
                  setState(() {
                    cepModel = cepData;
                  });
                }
              },
              child: Text('Localizar endereço'),
            ),
            SizedBox(height: 8.0),
            Text(
              'Últimos endereços localizados',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Observer(
              builder: (_) => ListWidgetHistory(history: cepController.cepStore.cepList), 
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.history);
              },
              child: Text('Histórico de endereços'),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.history);
          },
          child: Icon(Icons.route),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
