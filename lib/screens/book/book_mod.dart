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

class BookModState extends State<BookMod> {
  String appBarTitle = '';
  Book book;
  TextEditingController isbnController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  DatabaseHelper helper = DatabaseHelper();
  String? _errorText;

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
            child: TextFormField(
              controller: isbnController,
              decoration: InputDecoration(
                  labelText: 'ISBN',
                  errorText: _errorText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onChanged: (isbn) {
                _checkIsbn();
                _searchIsbn(isbn);
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

  void _setErrorText(String? errorText) {
    setState(() {
      _errorText = errorText;
    });
  }

  void _checkIsbn() async {
    final String isbn = isbnController.value.text;
    _setErrorText(await helper.isIsbnUsed(isbn)
        ? book.isbn == isbn
            ? null
            : 'ISBN is already used'
        : isbn.length > 13
            ? 'ISBN is too long'
            : null);
  }

  void _searchIsbn(String isbn) {
    debugPrint(isbn);
    String apiAuthor = '';
    String apiTitle = '';
    // TODO: search ofr isbn => see api in Haskell project
    if (authorController.text != '') {
      authorController.text = apiAuthor;
    }
    if (titleController.text != '') {
      titleController.text = apiTitle;
    }
  }

  void _save() async {
    if (_errorText != null) {
      _showAlertDialog('Status', 'ISBN not valid');
      return;
    }
    moveToLastScreen();
    int result;
    String oldIsbn = book.isbn;
    book.isbn = isbnController.text;
    book.author = authorController.text;
    book.title = titleController.text;

    if (oldIsbn != '') {
      result = await helper.updateBook(book, oldIsbn);
    } else {
      result = await helper.insertBook(book);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Book Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Book');
    }
  }

  void _delete() async {
    int result = 1;

    if (book.isbn != '') {
      result = await helper.deleteBook(book.isbn);
    }

    moveToLastScreen();

    if (result != 0) {
      _showAlertDialog('Status', 'Book Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Deleting Book');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    isbnController.dispose();
    authorController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
