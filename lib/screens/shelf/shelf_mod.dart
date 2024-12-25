import 'package:book_library/models/shelf.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ShelfMod extends StatefulWidget {
  final String appBarTitle;
  final Shelf shelf;
  const ShelfMod(this.appBarTitle, this.shelf, {super.key});
  @override
  State<StatefulWidget> createState() {
    return ShelfModState(appBarTitle, shelf);
  }
}

class ShelfModState extends State<ShelfMod> {
  String appBarTitle = '';
  Shelf shelf;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController isbnController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController shelfController = TextEditingController();
  TextEditingController boardController = TextEditingController();
  TextEditingController spotController = TextEditingController();
  ShelfModState(this.appBarTitle, this.shelf) {
    isbnController.text = shelf.isbn;
    placeController.text = shelf.place;
    shelfController.text = shelf.shelf;
    boardController.text = shelf.board;
    spotController.text = shelf.spot;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      // ISBN
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[
          // ISBN - TODO: selector aus vorhandenen isbn - auswahlmöglickhkeiten mit selbem anfang
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: isbnController,
              decoration: InputDecoration(
                  labelText: 'ISBN',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Author
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: placeController,
              decoration: InputDecoration(
                  labelText: 'Place',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: shelfController,
              decoration: InputDecoration(
                  labelText: 'Shelf',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: boardController,
              decoration: InputDecoration(
                  labelText: 'Board',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: spotController,
              decoration: InputDecoration(
                  labelText: 'Spot',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Save & Delete
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              children: <Widget>[
                // Save
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Save',
                      textScaler: TextScaler.linear(1.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _save();
                      });
                    },
                  ),
                ),
                // Delete
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Delete',
                      textScaler: TextScaler.linear(1.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _delete();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      // Save & Delete
    );
  }

  void _save() async {
    // TODO: if place is given (all combined) open screen with either:
    // - push all to right
    // - replace -> open the editor for that book, but close the editor before to end up at homescreen afterwards(for db change the values of to open bevore save)
    if (!checkIsbn(isbnController.text)) {
      _showAlertDialog('Status', 'ISBN not available');
      return;
    }
    moveToLastScreen();
    int result;
    if (shelf.isbn != '' &&
        shelf.place != '' &&
        shelf.shelf != '' &&
        shelf.board != '' &&
        shelf.spot != '') {
      String oldIsbn = shelf.isbn;
      String oldPlace = shelf.place;
      String oldShelf = shelf.shelf;
      String oldBoard = shelf.board;
      String oldSpot = shelf.spot;
      shelf.isbn = isbnController.text;
      shelf.place = placeController.text;
      shelf.shelf = shelfController.text;
      shelf.board = boardController.text;
      shelf.spot = spotController.text;
      result = await helper.updateShelf(
          shelf, oldIsbn, oldPlace, oldShelf, oldBoard, oldSpot);
    } else {
      shelf.isbn = isbnController.text;
      shelf.place = placeController.text;
      shelf.shelf = shelfController.text;
      shelf.board = boardController.text;
      shelf.spot = spotController.text;
      result = await helper.insertShelf(shelf);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Shelf Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Shelf');
    }
  }

  bool checkIsbn(String isbn) {
    // TODO check if isbn is given
    return isbn == '' ? false : true;
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _delete() async {
    int result = 1;
    if (shelf.isbn != '') {
      result = await helper.deleteBook(shelf.isbn);
    }
    moveToLastScreen();
    debugPrint(result.toString());
    if (result != 0) {
      _showAlertDialog('Status', 'Shelf Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Shelf Deleting Book');
    }
  }
}
