import 'package:sqflite/sqflite.dart' as  sql;
class SQLHelper{
 static String databaseName = "kindacode.db";
  static Future<void> createTable(sql.Database database) async {
    await database.execute(
      """ 
      CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
        databaseName,version: 1,onCreate: (sql.Database database, int version) async {
        await createTable(database);
    }
    );
  }

  static Future<int> createItem(String title,String description) async {
    final db = await SQLHelper.db();
    final data = {'title':title,'description':description};
    // avoid conflict record
    final id = await db.insert('items', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;

  }
  static Future<List<Map<String,dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items',orderBy: 'id');

  }
  static Future<List<Map<String,dynamic>>> getItem(int id) async{
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);

  }

  static Future<int> updateItem(int id,String title,String description) async {
    final db = await SQLHelper.db();
    final data = {
      'title':title,
      'description':description,
      'createdAt': DateTime.now().toString()
    };
    final result = db.update('items',data,where:"id = ?",whereArgs:[id]);
    return result;

  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete('items',where:'id = ?',whereArgs:[id]);
    }catch(err){
      print('something went wrong when deleting item : $err');
    }

  }



}

