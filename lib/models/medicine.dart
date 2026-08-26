class Medicine {
  const Medicine({
    required this.name,
    required this.dosage,
    required this.nextDose,
    required this.color,
    this.isTaken = false,
  });

  final String name;
  final String dosage;
  final String nextDose;
  final int color;
  final bool isTaken;

  Medicine copyWith({bool? isTaken}) {
    return Medicine(
      name: name,
      dosage: dosage,
      nextDose: nextDose,
      color: color,
      isTaken: isTaken ?? this.isTaken,
    );
  }
}