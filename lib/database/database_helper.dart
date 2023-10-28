class DatabaseHelper{
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal();
  static DatabaseHelper get instance => _databaseHelper ??= DatabaseHelper._internal();

  Database _db;
  Database get db => _db;

  Future<void> init() async {
    _db = await openDatabase()
  }
 }