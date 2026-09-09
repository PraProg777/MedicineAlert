import 'package:flutter/material.dart';

import 'app.dart';
//import 'database/db_provider.dart';

typedef MyApp = App;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Se comento el comando de abajo porque se esta probando en un entorno de linux desktop
  //await DBProvider.instance.database;
  runApp(const App());
}