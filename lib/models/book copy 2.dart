class Book {
  late String _isbn;
  late String _author;
  late String _title;

  Book(this._isbn, this._author, this._title);

  String get isbn => _isbn;
  String get author => _author;
  String get title => _title;

  set isbn(String newIsbn) {
    _isbn = newIsbn;
  }

  set author(String newAuthor) {
    _author = newAuthor;
  }

  set title(String newTitle) {
    _title = newTitle;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['isbn'] = _isbn;
    map['author'] = _author;
    map['title'] = _title;

    return map;
  }

  Book.fromMapObject(Map<String, dynamic> map) {
    _isbn = map['isbn'];
    _author = map['author'];
    _title = map['title'];
  }
}
