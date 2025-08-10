import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> getdatabase() async {
    if (_database != null) return _database!;
    _database = await _initDB("movies.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
        id TEXT PRIMARY KEY,
        title TEXT,
        posterUrl TEXT,
        description TEXT,
        releaseDate TEXT
      )
    ''');
  }

  Future<int> insertMovie(Map<String, dynamic> movie) async {
    final db = await getdatabase();
    return await db.insert(
      'movies',
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    final db = await getdatabase();
    return await db.query('movies');
  }

  Future<int> deleteMovie(int id) async {
    final db = await getdatabase();
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateMovie(int id, Map<String, dynamic> movie) async {
    final db = await getdatabase();
    await db.update('movies', movie, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await getdatabase();
    db.close();
  }
}
