import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'screens/example_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicineAlert',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MiPantalla(),
    );
  }
}