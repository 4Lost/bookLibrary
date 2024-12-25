import 'package:book_library/models/read.dart';
import 'package:book_library/models/records.dart';
import 'package:book_library/models/shelf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:book_library/models/book.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  // Book
  String bookTable = 'book_table';
  String bookColIsbn = 'isbn';
  String bookColAuthor = 'author';
  String bookColTitle = 'title';
  // Shelf
  String shelfTable = 'shelf_table';
  String shelfColIsbn = 'isbn';
  String shelfColPlace = 'place';
  String shelfColShelf = 'shelf';
  String shelfColBoard = 'board';
  String shelfColSpot = 'spot';
  // Read
  String readTable = 'read_table';
  String readColIsbn = 'isbn';
  String readColDate = 'date';
  // Record
  String recordTable = 'record_table';
  String recordColIsbn = 'isbn';
  String recordColComment = 'comment';

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
    String path = '/home/elias/Nextcloud/Data/Programms/bookLibrary.bd';

    var booksDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return booksDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $bookTable ($bookColIsbn VARCHAR(13) PRIMARY KEY, $bookColAuthor VARCHAR(13), $bookColTitle VARCHAR(30))');
    await db.execute(
        'CREATE TABLE $shelfTable ($shelfColIsbn VARCHAR(13), $shelfColPlace VARCHAR(10), $shelfColShelf VARCHAR(7), $shelfColBoard VARCHAR(7), $shelfColSpot VARCHAR(7), PRIMARY KEY ($shelfColPlace, $shelfColShelf, $shelfColBoard, $shelfColSpot), FOREIGN KEY ($shelfColIsbn) REFERENCES $bookTable ($bookColIsbn) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE $readTable ($readColIsbn VARCHAR(13), $readColDate DATE, PRIMARY KEY ($readColIsbn, $readColDate), FOREIGN KEY ($readColIsbn) REFERENCES $bookTable ($bookColIsbn) ON DELETE CASCADE)');
    await db.execute(
        'CREATE TABLE $recordTable ($recordColIsbn VARCHAR(13) PRIMARY KEY, $recordColComment VARCHAR(30), FOREIGN KEY ($recordColIsbn) REFERENCES $bookColIsbn ($bookColIsbn) ON DELETE CASCADE)');
  }

  // -- Book
  // Get List
  Future<List<Map<String, dynamic>>> getBookListMap() async {
    Database db = await database;
    var result = await db.query(bookTable, orderBy: '$bookColAuthor ASC');
    return result;
  }

  // Insert
  Future<int> insertBook(Book book) async {
    Database db = await database;
    var result = await db.insert(bookTable, book.toMap());
    return result;
  }

  // Update
  Future<int> updateBook(Book book, String isbn) async {
    Database db = await database;
    int result =
        await db.update(bookTable, book.toMap(), where: '$bookColIsbn = $isbn');
    return result;
  }

  // Delete
  Future<int> deleteBook(String isbn) async {
    Database db = await database;
    int result =
        await db.rawDelete('DELETE FROM $bookTable WHERE $bookColIsbn = $isbn');
    return result;
  }

  // Get NumberOf
  Future<int> getBookCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $bookTable');
    int? result = Sqflite.firstIntValue(x);
    result ??= 0;
    return result;
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
    var result = await db.query(shelfTable,
        orderBy:
            '$shelfColPlace, $shelfColShelf, $shelfColBoard, $shelfColSpot ASC');
    return result;
  }

  // Insert
  Future<int> insertShelf(Shelf shelf) async {
    Database db = await database;
    var result = await db.insert(shelfTable, shelf.toMap());
    return result;
  }

  // Update
  Future<int> updateShelf(Shelf shelf, String isbn, String place,
      String shelfVar, String board, String spot) async {
    Database db = await database;
    int result = await db.update(shelfTable, shelf.toMap(),
        where:
            '$shelfColIsbn = $isbn AND $shelfColPlace = $place AND $shelfColShelf = $shelfVar AND $shelfColBoard = $board AND $shelfColSpot = $spot');
    return result;
  }

  // Delete
  Future<int> deleteShelf(String isbn, String place, String shelfVar,
      String board, String spot) async {
    Database db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $shelfTable WHERE $shelfColIsbn = $isbn AND $shelfColPlace = $place AND $shelfColShelf = $shelfVar AND $shelfColBoard = $board AND $shelfColSpot = $spot');
    return result;
  }

  // Get NumberOf
  Future<int> getShelfCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $shelfTable');
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
    var result = await db.query(readTable, orderBy: '$readColDate ASC');
    return result;
  }

  // Insert
  Future<int> insertRead(Read read) async {
    Database db = await database;
    var result = await db.insert(readTable, read.toMap());
    return result;
  }

  // Update
  Future<int> updateRead(Read read, String isbn, String date) async {
    Database db = await database;
    int result = await db.update(readTable, read.toMap(),
        where: '$readColIsbn = $isbn AND $readColDate = $date');
    return result;
  }

  // Delete
  Future<int> deleteRead(String isbn, String date) async {
    Database db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $readTable WHERE $readColIsbn = $isbn AND $readColDate = $date');
    return result;
  }

  // Get NumberOf
  Future<int> getReadCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $readTable');
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
    var result = await db.query(recordTable, orderBy: '$recordColIsbn ASC');
    return result;
  }

  // Insert
  Future<int> insertRecord(Records record) async {
    Database db = await database;
    var result = await db.insert(readTable, record.toMap());
    return result;
  }

  // Update
  Future<int> updateRecord(Records record, String isbn) async {
    Database db = await database;
    int result = await db.update(recordTable, record.toMap(),
        where: '$recordColIsbn = $isbn');
    return result;
  }

  // Delete
  Future<int> deleteRecord(String isbn) async {
    Database db = await database;
    int result = await db
        .rawDelete('DELETE FROM $recordTable WHERE $recordColIsbn = $isbn');
    return result;
  }

  // Get NumberOf
  Future<int> getRecordCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $recordTable');
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
