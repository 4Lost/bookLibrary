import 'package:book_library/models/records.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

// TODO: fix dummy path

class RecordMod extends StatefulWidget {
  final String appBarTitle;
  final Records record;
  const RecordMod(this.appBarTitle, this.record, {super.key});
  @override
  State<StatefulWidget> createState() {
    return RecordModState(appBarTitle, record);
  }
}

class RecordModState extends State<RecordMod> {
  String appBarTitle = '';
  Records record;
  DatabaseHelper helper = DatabaseHelper('');
  TextEditingController isbnController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  RecordModState(this.appBarTitle, this.record) {
    isbnController.text = record.isbn;
    commentController.text = record.comment;
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
            ),
          ),
          // Comment
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                  labelText: 'Comment',
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
      _showAlertDialog('Status', 'ISBN not used');
      return;
    }
    moveToLastScreen();
    int result;
    if (record.isbn != '') {
      // check if already comment
      String oldIsbn = record.isbn;
      record.isbn = isbnController.text;
      record.comment = commentController.text;
      result = await helper.updateRecord(record, oldIsbn);
    } else {
      record.isbn = isbnController.text;
      record.comment = commentController.text;
      result = await helper.insertRecord(record);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Record Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Record');
    }
  }

  bool checkIsbn(String isbn) {
    // check if isbn is used
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
    if (record.isbn != '') {
      result = await helper.deleteRecord(record.isbn);
    }
    moveToLastScreen();
    debugPrint(result.toString());
    if (result != 0) {
      _showAlertDialog('Status', 'Record Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Deleting Record');
    }
  }
}
