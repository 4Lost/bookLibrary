import 'package:book_library/models/read.dart';
import 'package:book_library/models/records.dart';
import 'package:book_library/models/shelf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_library/models/book.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  // Book
  final String _bookTable = 'book_table';
  final String _bookColIsbn = 'isbn';
  final String _bookColAuthor = 'author';
  final String _bookColTitle = 'title';
  // Shelf
  final String _shelfTable = 'shelf_table';
  final String _shelfColIsbn = 'isbn';
  final String _shelfColPlace = 'place';
  final String _shelfColShelf = 'shelf';
  final String _shelfColBoard = 'board';
  final String _shelfColSpot = 'spot';
  // Read
  final String _readTable = 'read_table';
  final String _readColIsbn = 'isbn';
  final String _readColDate = 'date';
  // Record
  final String _recordTable = 'record_table';
  final String _recordColIsbn = 'isbn';
  final String _recordColComment = 'comment';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // TODO add get link from singleton login controller
    String path = '/home/elias/Nextcloud/Data/Programms/bookLibrary.bd';

    var booksDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return booksDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_bookTable ($_bookColIsbn VARCHAR(13) PRIMARY KEY, $_bookColAuthor VARCHAR(13), $_bookColTitle VARCHAR(30))');
    await db.execute(
        'CREATE TABLE $_shelfTable ($_shelfColIsbn VARCHAR(13), $_shelfColPlace VARCHAR(10), $_shelfColShelf VARCHAR(7), $_shelfColBoard VARCHAR(7), $_shelfColSpot VARCHAR(7), PRIMARY KEY ($_shelfColPlace, $_shelfColShelf, $_shelfColBoard, $_shelfColSpot), FOREIGN KEY ($_shelfColIsbn) REFERENCES $_bookTable ($_bookColIsbn) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE $_readTable ($_readColIsbn VARCHAR(13), $_readColDate DATE, PRIMARY KEY ($_readColIsbn, $_readColDate), FOREIGN KEY ($_readColIsbn) REFERENCES $_bookTable ($_bookColIsbn) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE $_recordTable ($_recordColIsbn VARCHAR(13) PRIMARY KEY, $_recordColComment VARCHAR(30), FOREIGN KEY ($_recordColIsbn) REFERENCES $_bookColIsbn ($_bookColIsbn) ON DELETE CASCADE)');
  }

  // -- Book
  // Get List
  Future<List<Map<String, dynamic>>> getBookListMap() async {
    Database db = await database;
    var result = await db.query(_bookTable, orderBy: '$_bookColAuthor ASC');
    return result;
  }

  // Insert
  Future<int> insertBook(Book book) async {
    Database db = await database;
    var result = await db.insert(_bookTable, book.toMap());
    return result;
  }

  // Update
  Future<int> updateBook(Book book, String isbn) async {
    Database db = await database;
    int result = await db.update(_bookTable, book.toMap(),
        where: '$_bookColIsbn = "$isbn"');
    return result;
  }

  // Delete
  Future<int> deleteBook(String isbn) async {
    Database db = await database;
    int result = await db
        .rawDelete('DELETE FROM $_bookTable WHERE $_bookColIsbn = "$isbn"');
    return result;
  }

  // Get NumberOf
  Future<int> getBookCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $_bookTable');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result;
  }

  // Get if
  Future<bool> isIsbnUsed(String isbn) async {
    Database db = await database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT (*) from $_bookTable WHERE $_bookColIsbn ="$isbn"');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result != 0 ? true : false;
  }

  // Map to List Helper
  Future<List<Book>> getBookList() async {
    var bookMapList = await getBookListMap();
    int count = bookMapList.length;

    List<Book> bookList = [];

    for (int i = 0; i < count; i++) {
      bookList.add(Book.fromMapObject(bookMapList[i]));
    }

    return bookList;
  }

  // -- Shelf
  // Get List
  Future<List<Map<String, dynamic>>> getShelfListMap() async {
    Database db = await database;
    var result = await db.query(_shelfTable,
        orderBy:
            '$_shelfColPlace, $_shelfColShelf, $_shelfColBoard, $_shelfColSpot ASC');
    return result;
  }

  // Insert
  Future<int> insertShelf(Shelf shelf) async {
    Database db = await database;
    var result = await db.insert(_shelfTable, shelf.toMap());
    return result;
  }

  // Update
  Future<int> updateShelf(Shelf shelf, String isbn, String place,
      String shelfVar, String board, String spot) async {
    Database db = await database;
    int result = await db.update(_shelfTable, shelf.toMap(),
        where:
            '$_shelfColIsbn = "$isbn" AND $_shelfColPlace = "$place" AND $_shelfColShelf = "$shelfVar" AND $_shelfColBoard = "$board" AND $_shelfColSpot = "$spot"');
    return result;
  }

  // Delete
  Future<int> deleteShelf(String isbn, String place, String shelfVar,
      String board, String spot) async {
    Database db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $_shelfTable WHERE $_shelfColIsbn = "$isbn" AND $_shelfColPlace = "$place" AND $_shelfColShelf = "$shelfVar" AND $_shelfColBoard = "$board" AND $_shelfColSpot = "$spot"');
    return result;
  }

  // Get NumberOf
  Future<int> getShelfCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $_shelfTable');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result;
  }

  // Map to List Helper
  Future<List<Shelf>> getShelfList() async {
    var shelfMapList = await getShelfListMap();
    int count = shelfMapList.length;

    List<Shelf> shelfList = [];

    for (int i = 0; i < count; i++) {
      shelfList.add(Shelf.fromMapObject(shelfMapList[i]));
    }

    return shelfList;
  }

  // -- Read
  // Get List
  Future<List<Map<String, dynamic>>> getReadListMap() async {
    Database db = await database;
    var result = await db.query(_readTable, orderBy: '$_readColDate ASC');
    return result;
  }

  // Insert
  Future<int> insertRead(Read read) async {
    Database db = await database;
    var result = await db.insert(_readTable, read.toMap());
    return result;
  }

  // Update
  Future<int> updateRead(Read read, String isbn, String date) async {
    Database db = await database;
    int result = await db.update(_readTable, read.toMap(),
        where: '$_readColIsbn = "$isbn" AND $_readColDate = "$date"');
    return result;
  }

  // Delete
  Future<int> deleteRead(String isbn, String date) async {
    Database db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $_readTable WHERE $_readColIsbn = "$isbn" AND $_readColDate = "$date"');
    return result;
  }

  // Get NumberOf
  Future<int> getReadCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $_readTable');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result;
  }

  // Map to List Helper
  Future<List<Read>> getReadList() async {
    var readMapList = await getReadListMap();
    int count = readMapList.length;

    List<Read> readList = [];

    for (int i = 0; i < count; i++) {
      readList.add(Read.fromMapObject(readMapList[i]));
    }

    return readList;
  }

  // -- Record
  // Get List
  Future<List<Map<String, dynamic>>> getRecordListMap() async {
    Database db = await database;
    var result = await db.query(_recordTable, orderBy: '$_recordColIsbn ASC');
    return result;
  }

  // Insert
  Future<int> insertRecord(Records record) async {
    Database db = await database;
    var result = await db.insert(_readTable, record.toMap());
    return result;
  }

  // Update
  Future<int> updateRecord(Records record, String isbn) async {
    Database db = await database;
    int result = await db.update(_recordTable, record.toMap(),
        where: '$_recordColIsbn = "$isbn"');
    return result;
  }

  // Delete
  Future<int> deleteRecord(String isbn) async {
    Database db = await database;
    int result = await db
        .rawDelete('DELETE FROM $_recordTable WHERE $_recordColIsbn = "$isbn"');
    return result;
  }

  // Get NumberOf
  Future<int> getRecordCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $_recordTable');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result;
  }

  // Map to List Helper
  Future<List<Records>> getRecordList() async {
    var recordMapList = await getRecordListMap();
    int count = recordMapList.length;

    List<Records> recordList = [];

    for (int i = 0; i < count; i++) {
      recordList.add(Records.fromMapObject(recordMapList[i]));
    }

    return recordList;
  }
}
