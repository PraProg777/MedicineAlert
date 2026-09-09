class Medicine {
  final int? id;                // Identificador unico del medicamento
  final DateTime time;          // Hora de carga del medicamento
  final String name;            // Nombre del medicamento
  final String dosage;          // Dosis del medicamento por vez que se consume
  final String frequency;       // Frecuencia de consumo del medicamento
  final bool temporary;         // Si es temporal o de por vida
  final int period;             // Si es temporal por cuanto tiempo (en dias)
  final DateTime startDate;     // Fecha de inicio del consumo del medicamento
  final bool dangerous;         // Es peligroso o no (requiere confirmacion de consumo)
  final String? notes;          // Notas adicionales sobre el medicamento

  Medicine({
    this.id,
    required this.time,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.temporary,
    required this.period,
    required this.startDate,
    required this.dangerous,
    this.notes,
  });

  // Mapeo para SQlite (convierte tipos complejas a tipos de soportados por SQL)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'temporary': temporary ? 1 : 0,
      'period': period,
      'startDate': startDate.toIso8601String(),
      'dangerous': dangerous ? 1 : 0,
      'notes': notes,
    };
  }

  // Reconstruye el objeto desde una fila de la BD o Map
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int?,
      time: DateTime.parse(map['time'] as String),
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      frequency: map['frequency'] as String,
      temporary: (map['temporary'] is int) ? map['temporary'] == 1 : map['temporary'] as bool,
      period: map['period'] as int,
      startDate: DateTime.parse(map['startDate'] as String),
      dangerous: (map['dangerous'] is int) ? map['dangerous'] == 1 : map['dangerous'] as bool,
      notes: map['notes'] as String?,
    );
  }
}