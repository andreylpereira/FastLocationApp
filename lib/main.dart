import 'package:fast_location_app/src/app_widget.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('cepBox'); 
  runApp(const AppWidget(title: 'Fast Location App'));
}
