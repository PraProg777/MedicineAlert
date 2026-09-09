import 'package:flutter/material.dart';

import 'app.dart';
import 'database/db_provider.dart';

typedef MyApp = App;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider.instance.database;
  runApp(const App());
}