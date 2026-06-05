import 'package:sqflite/sqflite.dart';
import '../user.dart';
import '../suporte/database_helper.dart';


class UserRepository {
  final DatabaseHelper _dbHelper;

  UserRepository(this._dbHelper);

  Future<int> insert(User user) async {
    final db = await _dbHelper.database;
    return await db.insert('User', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('User', where: 'id_user = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null;
  }

  Future<List<User>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query('User');
    return maps.map((map) => User.fromMap(map)).toList();
  }

  Future<int> update(User user) async {
    final db = await _dbHelper.database;
    return await db.update('User', user.toMap(), where: 'id_user = ?', whereArgs: [user.id]);
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('User', where: 'id_user = ?', whereArgs: [id]);
  }

  Future<User?> getByCredentials(String email, String password) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'User', 
      where: 'email = ? AND password = ?', 
      whereArgs: [email, password]
    );
    
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null; 
  }
}