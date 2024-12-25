import 'package:book_library/models/read.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

class ReadMod extends StatefulWidget {
  final String appBarTitle;
  final Read read;
  const ReadMod(this.appBarTitle, this.read, {super.key});
  @override
  State<StatefulWidget> createState() {
    return ReadModState(appBarTitle, read);
  }
}

class ReadModState extends State<ReadMod> {
  String appBarTitle = '';
  Read read;
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController isbnController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ReadModState(this.appBarTitle, this.read) {
    isbnController.text = read.isbn;
    dateController.text = read.date;
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
          // Date TODO maby limit to Date
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                  labelText: 'Date',
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
    if (read.isbn != '' && read.date != '') {
      String oldIsbn = read.isbn;
      String oldDate = read.date;
      read.isbn = isbnController.text;
      read.date = dateController.text;
      result = await helper.updateRead(read, oldIsbn, oldDate);
    } else {
      read.isbn = isbnController.text;
      read.date = dateController.text;
      result = await helper.insertRead(read);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Read Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Read');
    }
  }

  bool checkIsbn(String isbn) {
    // check if isbn is already used -> check also key
    // check if date is date
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
    if (read.isbn != '' && read.date != '') {
      result = await helper.deleteRead(read.isbn, read.date);
    }
    moveToLastScreen();
    debugPrint(result.toString());
    if (result != 0) {
      _showAlertDialog('Status', 'Read Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Deleting Read');
    }
  }
}
