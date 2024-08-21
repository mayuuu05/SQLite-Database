import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();
  DbHelper._();

  Database? _db;

  Future<Database?> get database async => _db ?? await initDatabase();

  Future<Database?> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'quotes.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''
        CREATE TABLE quotes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          quote TEXT NOT NULL,
          author TEXT NOT NULL,
          category TEXT);
        ''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future<void> insertQuote(String quote, String author, String category) async {
    Database? db = await database;
    String sql = '''
    INSERT INTO quotes (quote, author, category)
    VALUES (?, ?, ?);
    ''';
    await db!.rawInsert(sql, [quote, author, category]);
  }

  Future<List<Map<String, Object?>>> getQuotes() async {
    Database? db = await database;
    String sql = '''
    SELECT * FROM quotes;
    ''';
    return await db!.rawQuery(sql);
  }

  Future<void> deleteQuote(int id) async {
    Database? db = await database;
    String sql = '''
    DELETE FROM quotes WHERE id = ?;
    ''';
    await db!.rawDelete(sql, [id]);
  }
}
