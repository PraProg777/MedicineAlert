import 'package:flutter/material.dart';

class MiPantalla extends StatelessWidget {
  const MiPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi primer pantalla'),
      ),
      body: Center(
        child: Text('Hola, Flutter!'),
      ),
    );
  }
}