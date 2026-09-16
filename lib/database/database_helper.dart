import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('money_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
    path,
    version: 3, // increment version when schema changes
    onCreate: _createDB,
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute('''
          CREATE TABLE budget (
            id TEXT PRIMARY KEY,
            budget REAL
          );
        ''');
      }

       if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE money (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          expense REAL
        );
      ''');
    } 
    },
  );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        currency TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE expenses (
        id TEXT PRIMARY KEY,
        title TEXT,
        amount REAL,
        category TEXT,
        time TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE budget (
        id TEXT PRIMARY KEY AUTOINCREMENT,
        budget REAL
      );
    ''');

    await db.execute('''
      CREATE TABLE money (
        id TEXT PRIMARY KEY AUTOINCREMENT,
        expense REAL
      );
    ''');

  }

  Future<void> saveExpenseList(List<Map<String, dynamic>> expenses) async {
  final db = await instance.database;

  await db.delete('expenses');

  for (var expense in expenses) {
    await db.insert('expenses', {
      'id': expense['id'],
      'title': expense['title'],
      'amount': expense['amount'],
      'category': expense['category'],
      'time': expense['time'].toString(),
    });
  }
}

Future<List<Map<String, dynamic>>> loadExpenseList() async {
  final db = await instance.database;
  
  return await db.query('expenses');
}

Future<void> deleteExpense(String id) async {
  final db = await instance.database;
  await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
}




  Future<void> saveBudget(double budget) async{
    final db = await instance.database;
    await db.delete('budget');
    await db.insert('budget', {'budget' : budget});
  }


  Future<double?> loadBudget() async {
    final db = await instance.database;
    final result = await db.query('budget', limit: 1);
    return result.isNotEmpty ? result.first['budget'] as double : null;
  }

  Future<void> saveCurrency(String currency) async {
    final db = await instance.database;

    await db.delete('settings');

    await db.insert('settings', {'currency': currency});
  }

  Future<String?> loadCurrency() async {
    final db = await instance.database;
    final result = await db.query('settings', limit: 1);
    return result.isNotEmpty ? result.first['currency'] as String : null;
  }


  Future<void> saveMoney(double money) async {
    final db = await instance.database;

    await db.delete('money');

    await db.insert('money', {'expense': money});
  }

Future<double?> loadMoney() async {
    final db = await instance.database;
    final result = await db.query('money', limit: 1);
    return result.isNotEmpty ? result.first['expense'] as double : null;
  }

}
