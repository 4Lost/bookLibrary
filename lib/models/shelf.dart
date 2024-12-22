class Shelf {
  late String _isbn;
  late String _place;
  late String _shelf;
  late String _board;
  late String _spot;

  Shelf(this._isbn, this._place, this._shelf, this._board, this._spot);

  String get isbn => _isbn;
  String get place => _place;
  String get shelf => _shelf;
  String get board => _board;
  String get spot => _spot;

  set isbn(String newIsbn) {
    _isbn = newIsbn;
  }

  set place(String newPlace) {
    _place = newPlace;
  }

  set shelf(String newShelf) {
    _shelf = newShelf;
  }

  set board(String newBoard) {
    _board = newBoard;
  }

  set spot(String newSpot) {
    _spot = newSpot;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['isbn'] = _isbn;
    map['place'] = _place;
    map['shelf'] = _shelf;
    map['board'] = _board;
    map['spot'] = _spot;

    return map;
  }

  Shelf.fromMapObject(Map<String, dynamic> map) {
    _isbn = map['isbn'];
    _place = map['place'];
    _shelf = map['shelf'];
    _board = map['board'];
    _spot = map['spot'];
  }
}
