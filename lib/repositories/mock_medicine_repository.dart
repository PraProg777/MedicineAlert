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
}