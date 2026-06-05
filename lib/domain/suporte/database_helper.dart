import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('invezzte.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

  print("=========================================");
  print("O SEU BANCO DE DADOS ESTÁ EM: $path");
  print("=========================================");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const realType = 'REAL NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    // 1. User
    await db.execute('''
      CREATE TABLE User (
        id_user $idType,
        name $textType,
        email $textType,
        gender TEXT,
        saldo $realType DEFAULT 0.0,
        patrimony $realType DEFAULT 0.0,
        password TEXT
      )
    ''');

    // 2. Category
    await db.execute('''
      CREATE TABLE Category (
        id_category $idType,
        user_id INTEGER NOT NULL,
        name $textType,
        icon_name $textType,
        FOREIGN KEY (user_id) REFERENCES User (id_user) ON DELETE CASCADE
      )
    ''');

    // 3. Asset
    await db.execute('''
      CREATE TABLE Asset (
        id_asset $idType,
        user_id INTEGER NOT NULL,
        ticker $textType,
        name $textType,
        is_staking $boolType,
        current_price REAL,
        last_price_update TEXT,
        FOREIGN KEY (user_id) REFERENCES User (id_user) ON DELETE CASCADE
      )
    ''');

    // 4. Investment_Operation
    await db.execute('''
      CREATE TABLE Investment_Operation (
        id_investment $idType,
        asset_id INTEGER NOT NULL,
        operation_type $textType,
        total_amount $realType,
        quantity $realType,
        date $textType,
        FOREIGN KEY (asset_id) REFERENCES Asset (id_asset) ON DELETE CASCADE
      )
    ''');

    // 5. Transaction
    await db.execute('''
      CREATE TABLE "Transaction" (
        id_transaction $idType,
        user_id INTEGER NOT NULL,
        category_id INTEGER NOT NULL,
        title $textType,
        amount $realType,
        date $textType,
        type $textType,
        FOREIGN KEY (user_id) REFERENCES User (id_user) ON DELETE CASCADE,
        FOREIGN KEY (category_id) REFERENCES Category (id_category) ON DELETE CASCADE
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}