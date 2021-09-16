import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'my_accountant_home.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await GoolgeSheetsAPI.init();

  runApp(MyApp_home());
}


