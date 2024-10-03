import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? uf;

  const CardWidget({
    Key? key,
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: AppColors.cardBackgroundColor,
          ),
          color: AppColors.cardBackgroundColor,
        ),
        child: Center(
          child: cep != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('Dados da Localização',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                          textAlign: TextAlign.center),
                    ),
                    Text('CEP: $cep', style: TextStyle(fontSize: 16)),
                    Text('Localidade: ${localidade}/${uf}',
                        style: TextStyle(fontSize: 16)),
                    Text('Bairro: ${bairro}', style: TextStyle(fontSize: 16)),
                    Text('Logradouro: ${logradouro}',
                        style: TextStyle(fontSize: 16)),
                    if (complemento != null && complemento!.isNotEmpty)
                      Text('Complemento: $complemento',
                          style: TextStyle(fontSize: 16)),
                  ],
                )
              : Text(
                  'Efetue a localização de um endereço',
                  style: TextStyle(fontSize: 18, color: AppColors.textColor),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
