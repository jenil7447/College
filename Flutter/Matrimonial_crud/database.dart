import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  //singleton
  DBHelper._();

  static final DBHelper getInstance  = DBHelper._();
  Database? myDB;
  static final String TABLE_USER_DATA = 'user_data';


  //db open (path ->  if exist then open else create db)
  Future<Database> getDB() async{
    // if(myDB != null){
    //   return myDB!;
    // } else{
    //   myDB = await openDB();
    //   return myDB!;
    // }
    myDB = myDB ?? await openDB();
    return myDB!;
  }
  Future<Database> openDB() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path,"user_data.db");
    return await openDatabase(dbPath,onCreate: (db,version){
      // create your tables
      db.execute('''
      create table $TABLE_USER_DATA ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        number TEXT NOT NULL UNIQUE,
        dob TEXT NOT NULL,
        age INTEGER NOT NULL,
        city TEXT NOT NULL,
        gender INTEGER NOT NULL,
        hobbies TEXT NOT NULL,
        isLiked INTEGER NOT NULL DEFAULT 0
      )''');
    },version: 1);
  }
  //insert
  Future<int> insertUser({ required Map<String,dynamic>user}) async{
    final db = await myDB;
    user['hobbies'] = jsonEncode(user['hobbies']);
    try{
      return await db!.insert(TABLE_USER_DATA,user);
    }catch(e){
      print('Database insert error $e');
      return -1;
    }
  }
  //update
  Future<int> updateUser(int id,Map<String,dynamic> user) async{
    final db = await myDB;
    try{
      user['hobbies'] = jsonEncode(user['hobbies']);
      int result = await db!.update(TABLE_USER_DATA,
          user,where: 'id=?',whereArgs:[id]);
      print("Database update result: $result");
      return result;
    }catch(e){
      print("Database update error: $e");
      return 0;
    }
  }
  //deleteUser
  Future<int> deleteUser(int id)async{
    final db = await myDB;
    return await db!.delete(TABLE_USER_DATA,where: 'id=?',whereArgs: [id]);
  }
  //getUserByID

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await myDB;
    if (db == null) {
      return null;
    }

    List<Map<String, Object?>>? results = await db.query(
      TABLE_USER_DATA,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results == null || results.isEmpty) {
      return null;
    }

    try {
      // Ensure 'hobbies' is a String before decoding
      if (results[0]['hobbies'] is String) {
        results[0]['hobbies'] = jsonDecode(results[0]['hobbies'] as String);
      }
      // Cast the result to Map<String, dynamic>
      return results.first as Map<String, dynamic>;
    } catch (e) {
      print('Error decoding hobbies: $e');
      return null;
    }
  }
// search Users
  Future<List<Map<String, dynamic>>?> searchUsers(String query) async {
    final db = await myDB;
    if (db == null) {
      return null;
    }
    List<Map<String, dynamic>> results = await db.query(
      TABLE_USER_DATA,
      where: 'firstName LIKE ? OR lastName LIKE ? OR city LIKE ? OR email LIKE ? OR number LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%', '%$query%', '%$query%'],
    );

    for (var user in results) {
      user['hobbies'] = jsonDecode(user['hobbies']);
    }

    return results;
  }
  //update User Like Status
  Future<int> updateUserLikeStatus(int id, int isLiked) async {
    final db = await myDB;
    return await db!.update(
      TABLE_USER_DATA,
      {'isLiked': isLiked},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}