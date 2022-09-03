import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqflite {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  intialDatabase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'database.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 5, onUpgrade: _onUpgrade);
    // if we create a table and in future you want to update you cant directly
    // you must change the version and add the function _Onupdate
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("------ On upgrade is running");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
CREATE TABLE "notes" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "isdone" TEXT NOT NULL
)
''');
    batch.execute('''
CREATE TABLE "pespost" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "numberofplays" TEXT NOT NULL,
  "time" INTEGER NULL
)
''');
    batch.execute('''
CREATE TABLE "credit" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL,
  "amount" TEXT NOT NULL,
  "date" TEXT NOT NULL
)
''');
    batch.commit();
    print('create has succesfully');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  deletData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    print("done");
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  deleteallDatabase() async {
    // this function for delete all database
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'database.db');
    await deleteDatabase(path);
    print("done formating");
  }
}
