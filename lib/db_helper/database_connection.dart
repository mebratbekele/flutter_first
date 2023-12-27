import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud_flutter');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact Text,description TEXT)');
    await database.execute(
        'CREATE TABLE account (id INTEGER PRIMARY KEY, fname TEXT, lname TEXT, phone TEXT,email TEXT,password TEXT)');
    await database.close();
  }
}
