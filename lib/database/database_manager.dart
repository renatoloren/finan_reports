import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'reports.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_reports);
    // await db.insert('reports', {
    //   'title': 1,
    //   'date':' 2022-09-30 00:00:00',
    //   'taxSelic': 10.55,
    //   'taxFinan': 02.77,
    //   'performance': 'bom desempenho',
    //   'description': 'testtee'
    // });
  }

  String get _reports => '''
    CREATE TABLE IF NOT EXISTS reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date INTEGER,
      taxSelic REAL,
      taxFinan REAL,
      performance TEXT,
      description TEXT
    );
  ''';
}
