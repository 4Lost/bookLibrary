import 'package:basic_utils/basic_utils.dart';
import 'package:book_library/models/read.dart';
import 'package:book_library/models/records.dart';
import 'package:book_library/models/shelf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_library/models/book.dart';

class AccountHelper {
  static AccountHelper? _accountHelper;
  static Database? _database;

  late String _loggedInPath;

  String get path => _loggedInPath;

  final String _accountTable = 'account_table';
  final String _accountColName = 'name';
  final String _accountColPassword = 'password';
  final String _accountColPath = 'path';

  AccountHelper._createInstance();

  factory AccountHelper() {
    _accountHelper ??= AccountHelper._createInstance();
    return _accountHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String path = '/home/elias/Nextcloud/Data/Programms/accounts.bd';

    var db = await openDatabase(path, version: 1, onCreate: _createDB);
    return db;
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_accountTable ($_accountColName VARCHAR(20) PRIMARY KEY, $_accountColPassword VARCHAR(40), $_accountColPath VARCHAR(10))');
  }

  // Check Login Data
  Future<bool> checkLogin(String name, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> rows = await db.rawQuery(
        'SELECT * FROM $_accountTable WHERE $_accountColName = "$name" AND $_accountColPassword = "$password"');
    if (rows.length != 1) {
      return false;
    }
    _loggedInPath = rows[0][_accountColPath];
    return true;
  }

  // Insert
  Future<int> insertAccount(String name, String password) async {
    Database db = await database;
    Map<String, dynamic> account = {};
    account[_accountColName] = name;
    account[_accountColPassword] = password;
    account[_accountColPath] =
        StringUtils.generateRandomString(10, special: false, numeric: false);
    var result = await db.insert(_accountTable, account);
    return result;
  }

  // Update
  Future<int> updateAccount(
      String newName, String newPassword, String path, String oldName) async {
    Database db = await database;
    Map<String, dynamic> account = {};
    account[_accountColName] = newName;
    account[_accountColPassword] = newPassword;
    account[_accountColPath] = path;
    int result = await db.update(_accountTable, account,
        where: '$_accountColName = "$oldName"');
    return result;
  }

  // Delete
  Future<int> deleteAccount(String name) async {
    Database db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $_accountTable WHERE $_accountColName = "$name"');
    return result;
  }

  // Get if
  Future<bool> isNameUsed(String name) async {
    Database db = await database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) from $_accountTable WHERE $_accountColName ="$name"');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result != 0 ? true : false;
  }
}
