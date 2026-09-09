import 'package:flutter/material.dart';
import 'AddMedicineScreen.dart';

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
      body: Stack(
        children: [
          // Contenido principal de la pantalla de inicio
          const Center(  
            child: Text('Pantalla de inicio (en contrsuccion)')
          ),

          // Boton flotante para agregar un nuevo medicamento
          Positioned(
            top: 16,
            right: 16,
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, //Fondo rojo
                  foregroundColor: Colors.black, // Texto e icono negro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Forma rectangular
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  // Redirige a la pantalla de agragar medicamentos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMedicineScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.black), // Icono de agregar
                label: const Text(
                  'Agregar Medicamento',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],  
      ),
    );
  }
}