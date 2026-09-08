import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: const Text('Inicio'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      print('Boton superior presionado');
                    },
                  ),
                ],
              ),
      body: const Center(  
        child: Text('Pantalla de inicio (en contrsuccion)')
      ),
    );
  }
}