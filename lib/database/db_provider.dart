import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider instance = DBProvider._init();
  static Database? _database;

  DBProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'medicine_alert.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        time INTEGER NOT NULL,
        name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        frequency TEXT NOT NULL,
        temporary INTEGER NOT NULL,
        period INTEGER NOT NULL,
        startDate INTEGER NOT NULL,
        dangerous INTEGER NOT NULL,
        notes TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getMedicines() async {
    final db = await instance.database;
    return db.query('medicines', orderBy: 'id DESC');
  }

  Future<int> insertMedicine({
    required int time,
    required String name,
    required String dosage,
    required String frequency,
    required int temporary,
    required int period,
    required int startDate,
    required int dangerous,
    String? notes,
  }) async {
    final db = await instance.database;

    return db.insert('medicines', {
      'time': time,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'temporary': temporary,
      'period': period,
      'startDate': startDate,
      'dangerous': dangerous,
      'notes': notes,
    });
  }
}