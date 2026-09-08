import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  // Patron Singleton para mantener una sola instancia de la BD en toda la app
  static final DBProvider instance = DBProvider._init();
  static DataBase? _database;

  DBProvider._init();

  Future<DataBase> get database async {
    if (_database != null) return _database!;

    // Si no existe, inicializa la BD
    _database = await _initDB('medicine_alert.db');
    return _database!;
  }

  Future<DataBase> _initDB(String filePath) async {
    // Obtiene el directorio por defecto de bases de datos del sistema
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Abre o crea la BD indicando la version y la funcion onCreate
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Se ejecuta solamente la primera vez que la app se inicializa en el dispositivo
  Future _createDB(Database db, int version) async {
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

    // Metodos para interactuar con la base de datos

    // Obtener todas las consultas
    Future<List<Map<String dynamic>>> obtenerConsultas() async {
      final db = await instance.database;
      return await db.query('consultas', orderBy: 'id DESC);
    }

    // Insertar una nueva consulta
    Future<int> insertarConsulta(int Time, String Name, String Dosage, String Frecuency, int Period, int StartDate, int Dangerous, String Dengerous, String Note) async {
      final db = await instance.database;
      return await db.insert('consultas', {
        'time': Time,
        'name': Name,
        'dosage': Dosage,
        'frecuency': Frecuency,
        'period': Period,
        'startDate': StartDate,
        'dangerous': Dengerous,
        'notes': Note,
      });
    }
  }
}