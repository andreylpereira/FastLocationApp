import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int? data;

  @override
  void initState() {
    super.initState();
    data = 0; 
  }

  void _showSearchModal() {
    final TextEditingController controller = TextEditingController();

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
                decoration: InputDecoration(hintText: 'Digite o endereço'),
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
                onPressed: () {
                  String input = controller.text;
                  print('$input');
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            SizedBox(width: 8.0),
            Text(
              'Fast Location App',
              style: TextStyle(
                color: Colors.green,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.0),
            Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardWidget(data: data, color: Color.fromARGB(255, 210, 210, 210)), 
            SizedBox(height: 16.0),
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
            CardWidget(data: data), 
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              onPressed: () {
                setState(() {
                  data = (data ?? 0) + 1; 
                });
                print('${data}');
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
  final int? data;
  final Color? color; 

  const CardWidget({Key? key, this.data, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 210, 210, 210),
          ),
          color: color, 
        ),
        child: Center(
          child: data != null && data! >= 0
              ? Text(
                  data.toString(), 
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
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
