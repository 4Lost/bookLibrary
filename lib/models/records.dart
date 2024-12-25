class Records {
  late String _isbn;
  late String _comment;

  Records(this._isbn, this._comment);

  String get isbn => _isbn;
  String get comment => _comment;

  set isbn(String newIsbn) {
    _isbn = newIsbn;
  }

  set comment(String newComment) {
    _comment = newComment;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['isbn'] = _isbn;
    map['comment'] = _comment;

    return map;
  }

  Records.fromMapObject(Map<String, dynamic> map) {
    _isbn = map['isbn'];
    _comment = map['comment'];
  }
}
