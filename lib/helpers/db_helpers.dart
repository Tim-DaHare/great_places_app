import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: _onCreatePlacesDb,
      version: 1,
    );
  }

  static void _onCreatePlacesDb(sql.Database db, int idk) async {
    return await db.execute(
      "CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT)",
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await getDb();
    return await db.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await getDb();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
