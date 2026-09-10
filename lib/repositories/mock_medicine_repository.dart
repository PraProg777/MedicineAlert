import '../models/medicine.dart';
import 'medicine_repository.dart';

class MockMedicamentosRepository implements MedicineRepository {
  final List<Medicine> _tablaMedicamentos = [];
  int _contadorId = 1;

  @override
  Future<List<Medicine>> getAllMedicines() async {
    await Future.delayed(const Duration(milliseconds: 200));

    final listaOrdenada = List<Medicine>.from(_tablaMedicamentos);
    listaOrdenada.sort((a, b) => b.time.compareTo(a.time));
    return listaOrdenada;
  }

  @override
  Future<void> addMedicine(Medicine medicine) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final nuevo = Medicine(
      id: _contadorId++,
      time: medicine.time,
      name: medicine.name,
      dosage: medicine.dosage,
      frequency: medicine.frequency,
      temporary: medicine.temporary,
      period: medicine.period,
      startDate: medicine.startDate,
      dangerous: medicine.dangerous,
      notes: medicine.notes,
    );

    _tablaMedicamentos.add(nuevo);
    print('MOCK LOG: Medicamento "${nuevo.name}" guardado correctamente con ID: ${nuevo.id}');
  }

  @override
  Future<Medicine?> getMedicine(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _tablaMedicamentos.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> deleteMedicine(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tablaMedicamentos.removeWhere((item) => item.id == id);
    print('MOCK LOG: Medicamento con ID $id eliminado.');
  }

  // Imprime el estado actual de la "base de datos virtual" en la terminal
  void imprimirEstadoEnTerminal() {
    print('\n==================================================');
    print('       ESTADO DE LA BASE DE DATOS VIRTUAL (MOCK)  ');
    print('==================================================');
    
    if (_tablaMedicamentos.isEmpty) {
      print(' [BD VACÍA] No hay registros almacenados.');
    } else {
      print(' Total registros: ${_tablaMedicamentos.length}\n');
      
      for (var m in _tablaMedicamentos) {
        print('--------------------------------------------------');
        print(' ID:        ${m.id}');
        print(' Nombre:    ${m.name}');
        print(' Dosis:     ${m.dosage}');
        print(' Frecuencia:${m.frecuancy}');
        print(' Creado:    ${m.time.toIso8601String()}');
        print(' Inicio:    ${m.startDate.day}/${m.startDate.month}/${m.startDate.year}');
        print(' Temporal:  ${m.temporary ? "SÍ (Periodo: ${m.period})" : "NO"}');
        print(' Peligroso: ${m.dangerous ? "SÍ ⚠️" : "NO"}');
        print(' Notas:     ${m.notes ?? "Ninguna"}');
      }
    }
    print('==================================================\n');
  }
}