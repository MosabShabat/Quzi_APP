import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    // ? => accept null //use get db in function (select , insert , delete )
    if (_db == null) {
      // check if DB initialized
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath(); // default path
    String path = join(databasePath,
        'Quiz.db'); //pass path and Name of DB => databasePath/Quiz.db
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade); // create BD //
    return myDB;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("on Upgrade >>>>>>>>>");
  }

  _onCreate(Database db, int version) async {
    // create Table // call the function once when construct DB

    await db.execute('CREATE TABLE AddQuestions ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'Question TEXT NOT NULL,'
        'FirstAnswer TEXT NOT NULL,'
        'SecondAnswer TEXT NOT NULL,'
        'ThirdAnswer TEXT NOT NULL,'
        'FourthAnswer TEXT NOT NULL,'
        'CorrectAnswer TEXT NOT NULL'
        ')');
  }

  readData(String sql) async {
    //select

    Database? myDB = await db;
    List<Map> response = await myDB!
        .rawQuery(sql); // why but ! => can not use method by value accept null
    return response;
  }

  insertData(String sql) async {
    //insert

    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    // بترجع قيمة row الي تم اضافتو // return 0 if fail
    return response;
    //  print("insert successful!>>>>>>>>>>>>>>>>>>>>>>>>");
  }

  updateData(String sql) async {
    //update

    Database? myDB = await db;
    int response = await myDB!
        .rawUpdate(sql); // why but ! => can not use method by value accept null
    return response;
  }

  deleteData(String sql) async {
    //select
    Database? myDB = await db;
    int response = await myDB!
        .rawDelete(sql); // why but ! => can not use method by value accept null
    return response;
  }
}
