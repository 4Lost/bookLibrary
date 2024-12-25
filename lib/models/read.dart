class Read {
  late String _isbn;
  late String _date;

  Read(this._isbn, this._date);

  String get isbn => _isbn;
  String get date => _date;

  set isbn(String newIsbn) {
    _isbn = newIsbn;
  }

  set date(String newDate) {
    _date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['isbn'] = _isbn;
    map['date'] = _date;

    return map;
  }

  Read.fromMapObject(Map<String, dynamic> map) {
    _isbn = map['isbn'];
    _date = map['date'];
  }
}
