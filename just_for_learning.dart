import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataSqfLite {
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
    String path = join(dataBasePath, 'databaseGameroom.db');
    Database mydata =
        await openDatabase(path, onCreate: OnCreation, version: 1);
    return mydata;
  }

  OnCreation(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE "notes" (
      "id" INTEGER NOT NULL ,
      "name" TEXT NOT NULL
    )
''');
    batch.commit();
    print("create has succesfully");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // insert and update and delete data is all the same just we change the String to integer
  //
  deletallData() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'database.db');
    await deleteDatabase(path);
  }
}
