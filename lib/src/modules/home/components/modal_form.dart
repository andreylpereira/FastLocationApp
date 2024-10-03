import 'package:fast_location_app/src/modules/home/components/invalid_cep_modal.dart';
import 'package:fast_location_app/src/modules/home/controller/cep_controller.dart';
import 'package:fast_location_app/src/modules/home/service/cep_service.dart';
import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fast_location_app/src/http/http_client.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_repository.dart';

class ModalForm {
  static Future<CEPModel?> show(BuildContext context, CEPController cepController) async {
    final TextEditingController controller = TextEditingController();
    final cepRepository = CEPRepository(CEPService(HttpClient()));

    return showDialog<CEPModel?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar Endereço'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Digite o CEP'),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  onPrimary: AppColors.secondaryColor,
                ),
                onPressed: () async {
                  String cepInput = controller.text;
                  CEPModel? cepData;

                  try {
                    cepData = await cepRepository.getCEP(cepInput);
                    if (cepData?.cep != null) {
                      await cepController.saveCEP(cepData);
                      await cepController.loadCEPs();
                      Navigator.of(context).pop(cepData);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return InvalidCepModal();
                        },
                      );
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InvalidCepModal();
                      },
                    );
                  }
                },
                child: Text('Buscar'),
              ),
            ),
          ],
        );
      },
    );
  }
}
