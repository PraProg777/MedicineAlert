import 'package:flutter/material.dart';

import '../models/medicine.dart';
import '../repositories/mock_medicine_repository.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _repository = MockMedicamentosRepository();

  final _nameCtrl = TextEditingController();
  final _dosageCtrl = TextEditingController();
  final _frequencyCtrl = TextEditingController();
  final _periodCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  bool _temporary = false;
  bool _dangerous = false;
  DateTime _startDate = DateTime.now();
  bool _guardando = false;

  Future<void> _seleccionarFechaInicio() async {
    final seleccionada = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (seleccionada != null) {
      setState(() => _startDate = seleccionada);
    }
  }

  Future<void> _guardar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _guardando = true);

      final periodValue = int.tryParse(_periodCtrl.text.trim());

      final nuevoMedicamento = Medicine(
        time: DateTime.now(),
        name: _nameCtrl.text.trim(),
        dosage: _dosageCtrl.text.trim(),
        frequency: _frequencyCtrl.text.trim(),
        temporary: _temporary,
        period: _temporary ? (periodValue ?? 0) : 0,
        startDate: _startDate,
        dangerous: _dangerous,
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      );

      await _repository.addMedicine(nuevoMedicamento);

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cargar Medicamento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre (name)', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dosageCtrl,
                decoration: const InputDecoration(labelText: 'Dosis (dosage)', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _frequencyCtrl,
                decoration: const InputDecoration(labelText: 'Frecuencia (frequency)', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),

              // Fecha de Inicio (startDate)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Fecha de inicio: ${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _seleccionarFechaInicio,
              ),
              const Divider(),

              // Tratamiento Temporal (temporary)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('¿Es un tratamiento temporal? (temporary)'),
                value: _temporary,
                onChanged: (val) => setState(() => _temporary = val),
              ),

              if (_temporary) ...[
                TextFormField(
                  controller: _periodCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Periodo (period - ej. 7)', border: OutlineInputBorder()),
                  validator: (v) {
                    if (!_temporary) return null;
                    if (v == null || v.trim().isEmpty) return 'Requerido en temporales';
                    if (int.tryParse(v.trim()) == null) return 'Debe ser un número';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
              ],

              // Riesgo Alto / Peligroso (dangerous)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('¿Es de cuidado especial / alto riesgo? (dangerous)'),
                value: _dangerous,
                activeThumbColor: Colors.red,
                onChanged: (val) => setState(() => _dangerous = val),
              ),
              const Divider(),

              // Notas (notes)
              TextFormField(
                controller: _notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Notas adicionales (notes)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: _guardando
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        onPressed: _guardar,
                        child: const Text('Guardar en BD', style: TextStyle(fontSize: 16)),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}