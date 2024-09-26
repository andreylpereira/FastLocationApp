import 'package:flutter/material.dart';

class InvalidCepModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('CEP Inválido'),
      content: Text('Por favor, insira um CEP válido.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Fechar'),
        ),
      ],
    );
  }
}
