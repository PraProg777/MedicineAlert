import 'package:flutter/material.dart';

import '../models/medicine.dart';
import '../repositories/mock_medicine_repository.dart';
import 'add_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _repository = MockMedicamentosRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              debugPrint('Boton superior presionado');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Medicine>>(
            future: _repository.getAllMedicines(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error al cargar medicamentos: ${snapshot.error}'),
                );
              }

              final lista = snapshot.data ?? const <Medicine>[];
              if (lista.isEmpty) {
                return const Center(child: Text('No hay medicamentos cargados.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 16),
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final item = lista[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(
                        item.dangerous ? Icons.warning_amber_rounded : Icons.medication,
                        color: item.dangerous ? Colors.red : Colors.blue,
                        size: 32,
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item.dosage} - ${item.frequency}'),
                          if (item.temporary)
                            Text('Periodo: ${item.period} días',
                                style: const TextStyle(fontSize: 12)),
                          if (item.notes != null && item.notes!.isNotEmpty)
                            Text(
                              'Notas: ${item.notes}',
                              style: const TextStyle(fontStyle: FontStyle.italic),
                            ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.access_time, size: 14, color: Colors.grey),
                          Text(
                            '${item.time.hour}:${item.time.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            top: 16,
            right: 16,
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMedicineScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.black),
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