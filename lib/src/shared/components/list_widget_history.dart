import 'package:flutter/material.dart';
import 'package:fast_location_app/src/modules/home/model/cep_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class ListWidgetHistory extends StatelessWidget {
  final ObservableList<CEPModel> history;

  const ListWidgetHistory({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
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
      },
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('${item.bairro}', textAlign: TextAlign.start,  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text('${item.localidade}, ${item.uf}', textAlign: TextAlign.end,  style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text('${item.logradouro}', textAlign: TextAlign.start,  style: TextStyle(fontSize: 14, color: Colors.black)), 
                  ),
                  Expanded(
                    child: Text('${item.cep}', textAlign: TextAlign.end, style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
