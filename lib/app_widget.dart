import 'package:fast_location_app/src/modules/home/page/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
