import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // singleton
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();
  Database? myDB;
  static final String TABLE_USER_DATA = 'user_data';

  Future<Database> getDB() async {
    myDB = myDB ?? await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "user_data.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        // create your tables
        db.execute('''
        create table $TABLE_USER_DATA ( 
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          firstName TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          mobile TEXT NOT NULL UNIQUE,
          dob TEXT NOT NULL,
          age INTEGER NOT NULL,
          city TEXT NOT NULL,
          gender INTEGER NOT NULL,
          hobbies TEXT NOT NULL,
          isFavorite INTEGER NOT NULL DEFAULT 0
        )''');
        // Insert default users after table creation
        await insertDefaultUsers(db);
      },
      version: 1,
    );
  }

  Future<void> insertDefaultUsers(Database db) async {
    List<Map<String, dynamic>> defaultUsers = [
      {
        'firstName': 'John',
        'email': 'john@example.com',
        'mobile': '1234567890',
        'dob': '1990-01-01',
        'age': 33,
        'city': 'New York',
        'gender': 1,
        'hobbies': jsonEncode(['reading', 'swimming']),
        'isFavorite': 0
      },
      {
        'firstName': 'Sarah',
        'email': 'sarah@example.com',
        'mobile': '9876543210',
        'dob': '1995-05-15',
        'age': 28,
        'city': 'Los Angeles',
        'gender': 2,
        'hobbies': jsonEncode(['painting', 'yoga']),
        'isFavorite': 1
      }
    ];

    for (var user in defaultUsers) {
      try {
        await db.insert(TABLE_USER_DATA, user);
      } catch (e) {
        print('Error inserting default user: $e');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await getDB();
    List<Map<String, dynamic>> results = await db.query(TABLE_USER_DATA);

    // Decode hobbies JSON string for each user
    return results.map((user) {
      if (user['hobbies'] is String) {
        user['hobbies'] = jsonDecode(user['hobbies'] as String);
      }
      return user;
    }).toList();
  }

  Future<int> insertUser({required Map<String, dynamic> user}) async {
    final db = await getDB();
    try {
      // Ensure hobbies is encoded as JSON string
      if (user['hobbies'] is! String) {
        user['hobbies'] = jsonEncode(user['hobbies']);
      }
      return await db.insert(TABLE_USER_DATA, user);
    } catch (e) {
      print('Database insert error $e');
      return -1;
    }
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await getDB();
    try {
      // Ensure hobbies is encoded as JSON string
      if (user['hobbies'] is! String) {
        user['hobbies'] = jsonEncode(user['hobbies']);
      }
      int result = await db.update(
        TABLE_USER_DATA,
        user,
        where: 'id = ?',
        whereArgs: [id],
      );
      print("Database update result: $result");
      return result;
    } catch (e) {
      print("Database update error: $e");
      return 0;
    }
  }

  Future<int> deleteUser(int id) async {
    final db = await getDB();
    return await db.delete(
      TABLE_USER_DATA,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    final db = await getDB();
    List<Map<String, Object?>> results = await db.query(
      TABLE_USER_DATA,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) {
      return null;
    }

    try {
      Map<String, dynamic> user = Map<String, dynamic>.from(results.first);
      // Decode hobbies JSON string
      if (user['hobbies'] is String) {
        user['hobbies'] = jsonDecode(user['hobbies']);
      }
      return user;
    } catch (e) {
      print('Error processing user data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    final db = await getDB();
    List<Map<String, dynamic>> results = await db.query(
      TABLE_USER_DATA,
      where: query.isEmpty ? null : 'firstName LIKE ? OR email LIKE ? OR mobile LIKE ? OR city LIKE ?',
      whereArgs: query.isEmpty ? null : ['%$query%', '%$query%', '%$query%', '%$query%'],
    );

    // Decode hobbies JSON string for each user
    return results.map((user) {
      if (user['hobbies'] is String) {
        user['hobbies'] = jsonDecode(user['hobbies'] as String);
      }
      return user;
    }).toList();
  }

  Future<int> updateUserFavoriteStatus(int id, int isFavorite) async {
    final db = await getDB();
    return await db.update(
      TABLE_USER_DATA,
      {'isFavorite': isFavorite},
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}