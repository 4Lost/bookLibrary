import 'package:book_library/models/book.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

class BookMod extends StatefulWidget {
  final String appBarTitle;
  final Book book;
  const BookMod(this.appBarTitle, this.book, {super.key});
  @override
  State<StatefulWidget> createState() {
    return BookModState(appBarTitle, book);
  }
}
// TODO: Maby add more values => look up at api what possible
class BookModState extends State<BookMod> {
  String appBarTitle = '';
  Book book;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController isbnController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  BookModState(this.appBarTitle, this.book) {
    isbnController.text = book.isbn;
    authorController.text = book.author;
    titleController.text = book.title;
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
          // ISBN
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: isbnController,
              decoration: InputDecoration(
                  labelText: 'ISBN',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onChanged: (isbn) {
                searchIsbn(isbn);
              },
            ),
          ),
          // Author
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: authorController,
              decoration: InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
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
    if (!checkIsbn(isbnController.text)) {
      _showAlertDialog('Status', 'ISBN not valid');
      return;
    }
    moveToLastScreen();
    int result;
    if (book.isbn != '') {
      String oldIsbn = book.isbn;
      book.isbn = isbnController.text;
      book.author = authorController.text;
      book.title = titleController.text;
      result = await helper.updateBook(book, oldIsbn);
    } else {
      book.isbn = isbnController.text;
      book.author = authorController.text;
      book.title = titleController.text;
      result = await helper.insertBook(book);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Book Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Book');
    }
  }

  bool checkIsbn(String isbn) {
    // TODO: Check ob isbn nicht zu lang ist
    // TODO: wenn schon vorhanden und ungleich book.isbn eine fehlermeldung ausgeben ud false zurück geben.
    // TODO: Fehlermeldungen für vershciedene nicht passend eingaben
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
    if (book.isbn != '') {
      result = await helper.deleteBook(book.isbn);
    }
    moveToLastScreen();
    debugPrint(result.toString());
    if (result != 0) {
      _showAlertDialog('Status', 'Book Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Deleting Book');
    }
  }

  void searchIsbn(String isbn) {
    // TODO: search ofr isbn => see api in Haskell project
    // TODO: load data if found into empty field.
    if authorController
  }
}
