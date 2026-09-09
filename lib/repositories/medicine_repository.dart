import 'models/medicine.dart';

abstract class MedicineRepository {
  Future<List<Medicine>> getAllMedicines();
  Future<void> addMedicine(Medicine medicine);
  Future<Medicine?> getMedicine(int id);
  Future<void> deleteMedicine(int id);
}