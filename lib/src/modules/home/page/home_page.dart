import 'package:fast_location_app/src/http/http_client.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:fast_location_app/src/modules/home/repositories/cep_repository.dart';
import 'package:fast_location_app/src/services/cep_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  List<CEPModel> history = [];

  @override
  void initState() {
    super.initState();
  }

  void _showSearchModal() {
    final TextEditingController controller = TextEditingController();
    final cepRepository = CEPRepository(CEPService(HttpClient()));

    showDialog(
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
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                onPressed: () async {
                  String cepInput = controller.text;
                  try {
                    CEPModel cepData = await cepRepository.buscarCEP(cepInput);
                    if (cepData.erro) {
                      print('CEP não encontrado!');
                    } else {
                      setState(() {
                        cep = cepData.cep;
                        logradouro = cepData.logradouro;
                        complemento = cepData.complemento;
                        bairro = cepData.bairro;
                        localidade = cepData.localidade;
                        uf = cepData.uf;
                        history.add(cepData);
                      });
                      print('CEP: ${cepData.cep}');
                      print('Logradouro: ${cepData.logradouro}');
                      print('Complemento: ${cepData.complemento}');
                      print('Bairro: ${cepData.bairro}');
                      print('Localidade: ${cepData.localidade}');
                      print('UF: ${cepData.uf}');
                    }
                  } catch (e) {
                    print('Erro ao buscar CEP: $e');
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Buscar'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 220, 220),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: Colors.green),
            SizedBox(width: 8.0),
            Text(
              'Fast Location App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.arrow_forward, color: Colors.green),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 220, 220, 220)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardWidget(
                cep: cep,
                logradouro: logradouro,
                complemento: complemento,
                bairro: bairro,
                localidade: localidade,
                uf: uf),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              onPressed: _showSearchModal,
              child: Text('Localizar endereço'),
            ),
            SizedBox(height: 16.0),
            ListWidgetHistory(history: history),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              onPressed: () {
                //falta criar rotas
              },
              child: Text('Histórico de endereços'),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final Color? color;

  const CardWidget(
      {Key? key,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 200, 200, 200),
          ),
          color: Color.fromARGB(255, 201, 201, 201),
        ),
        child: Center(
          child: cep != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('CEP: $cep', style: TextStyle(fontSize: 26)),
                    Text('Localidade: $localidade/$uf',
                        style: TextStyle(fontSize: 16)),
                    Text('Bairro: $bairro', style: TextStyle(fontSize: 16)),
                    Text('Logradouro: $logradouro',
                        style: TextStyle(fontSize: 16)),
                    Text('Complemento: $complemento',
                        style: TextStyle(fontSize: 16)),
                  ],
                )
              : Text(
                  'Nenhum dado disponível',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}

class ListWidgetHistory extends StatelessWidget {
  final List<CEPModel> history;

  const ListWidgetHistory({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[history.length - 1 - index];
          return _buildList(item);
        },
      ),
    );
  }

  Widget _buildList(CEPModel item) {
    return Container(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text('${item.logradouro}, ${item.bairro}'),
          subtitle: Text('${item.localidade} - ${item.uf}'),
        ),
      ),
    );
  }
}
