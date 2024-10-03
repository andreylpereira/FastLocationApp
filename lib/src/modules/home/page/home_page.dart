import 'package:fast_location_app/src/shared/components/list_widget_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location_app/src/modules/home/components/home_appbar.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_repository.dart';

import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_local_repository.dart';
import 'package:fast_location_app/src/http/http_client.dart';
import 'package:fast_location_app/src/shared/storage/cep_store.dart';
import 'package:fast_location_app/src/modules/home/controller/cep_controller.dart';
import 'package:fast_location_app/src/routes/app_routes.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/components/card_widget.dart';
import 'package:fast_location_app/src/modules/home/components/modal_form.dart';
import 'package:hive/hive.dart';
import 'package:fast_location_app/src/modules/home/service/cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final CEPController cepController;
  CEPModel? cepModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final Box<String> box = Hive.box<String>('cepBox');
    final cepStore = CEPStore(box);
    final cepService = CEPService(HttpClient());
    
    final cepRepository = CEPRepository(cepService);
    final cepLocalRepository = CEPLocalRepository(cepStore);

    cepController = CEPController(cepRepository, cepLocalRepository);
    cepController.loadCEPs();
  }

  Future<void> _searchAddress() async {
    final cepData = await ModalForm.show(context, cepController);
    if (cepData != null) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 1));

      setState(() {
        cepModel = cepData;
        isLoading = false;
      });
    }
  }

  Future<void> _openMaps() async {
    if (cepModel != null) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 1));

      await cepController.openMaps(cepModel!);
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nenhum endereço foi localizado.")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _openHistory() async {
    Navigator.pushNamed(context, AppRoutes.history);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.backgroundColor),
            padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    onPrimary: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: _searchAddress,
                  child: Text('Localizar endereço'),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Últimos endereços localizados',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Observer(
                  builder: (_) => ListWidgetHistory(history: cepController.cepLocalRepository.cepList),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    onPrimary: AppColors.secondaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: _openHistory,
                  child: Text('Histórico de endereços'),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: AppColors.secondaryColor.withOpacity(0.8), 
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: _openMaps,
          child: Icon(Icons.route),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}