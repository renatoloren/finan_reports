import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'reports.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_reports);
    await db.insert('sa', {
      'title': 1,
      'date': '2022-09-30 00:00:00',
      't_selic': 10.55,
      't_finan': 02.77,
      'performance': 2,
      'description': 'testtee'
    });
  }

  String get _reports => '''
    CREATE TABLE IF NOT EXISTS reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      date TEXT,
      t_selic REAL,
      t_finan REAL,
      performance INTEGER,
      description TEXT
    );
  ''';
}
