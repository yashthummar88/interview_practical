import 'package:path/path.dart';
import 'package:practical_task_interview/models/attribute_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  String TABLE = "product";
  var database;

  Future<Database> initDB() async {
    if (database == null) {
      database = openDatabase(
        join(await getDatabasesPath(), "product_db070.db"),
        version: 1,
        onCreate: (db, version) {
          String sql =
              "CREATE TABLE $TABLE(id INTEGER, attribute TEXT,PRIMARY KEY('id' AUTOINCREMENT))";
          return db.execute(sql);
        },
      );
      return database;
    }
    return database;
  }

  Future<int> insertData({Attribute? s}) async {
    var db = await initDB();
    String sql = "INSERT INTO $TABLE(attribute)VALUES('${s!.attribute}')";
    return await db.rawInsert(sql);
  }

  Future<int> deleteProduct(int? id) async {
    var db = await initDB();

    String query = "DELETE FROM $TABLE WHERE id=$id";
    int deletedId = await db.rawDelete(query);
    return deletedId;
  }

  Future<List<Attribute>> getAllAttribute() async {
    var db = await initDB();
    String sql = "SELECT * FROM $TABLE";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Attribute> response =
        res.map((record) => Attribute.fromMap(record)).toList();
    return response;
  }
}

DBHelper dbh = DBHelper._();
