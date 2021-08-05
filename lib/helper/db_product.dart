import 'package:path/path.dart';
import 'package:practical_task_interview/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperProduct {
  DBHelperProduct._();
  String table = "Products";
  var database;
  static List<String> products = [
    "INSERT INTO Products(name,quantity,type)VALUES('Volvo',10,'Car')",
  ];
  initDB() async {
    if (database == null) {
      database = openDatabase(join(await getDatabasesPath(), "product_040.db"),
          version: 1, onCreate: (db, version) {
        String sql =
            "CREATE TABLE $table(id INTEGER, name TEXT,quantity INTEGER,type TEXT,PRIMARY KEY('id' AUTOINCREMENT))";
        db.execute(sql);
        insertData();
      });
    }
    return database;
  }

  void insertData() async {
    var db = await initDB();
    products.forEach((element) async {
      var res = await db.rawInsert(element);
      print(res);
    });
  }

  addData({Product? products}) async {
    var db = await initDB();
    String sql =
        "INSERT INTO Products(name,quantity,type)VALUES('${products!.name}',${products.quantity},'${products.type}')";
    return await db.rawInsert(sql);
  }

  Future<List<Product>> getAllData() async {
    var db = await initDB();
    String sql = "SELECT * FROM $table ";
    List<Map<String, dynamic>> res = await db.rawQuery(sql);
    List<Product> response =
        res.map((record) => Product.fromMap(record)).toList();
    print(response);
    return response;
  }
}

DBHelperProduct dbproduct = DBHelperProduct._();
