import 'package:book_library/screens/book/book_mod.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:book_library/models/book.dart';
import 'package:sqflite/sqflite.dart';

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<StatefulWidget> createState() {
    return BookViewState();
  }
}

class BookViewState extends State<BookView> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Book> bookList = [];
  int count = 0;
  @override
  // TODO: Eventuell Rahmen um Tabelle / Bessere Idee als Tabelle?
  Widget build(BuildContext context) {
    updateListView();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        body: Center(
            child: ListView(children: [
          _createDataTable(context),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToMod(context, 'Add Book', Book('', '', ''));
          },
          tooltip: 'Add Book',
          child: const Text('+'),
        ));
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ISBN')),
      const DataColumn(label: Text('Author')),
      const DataColumn(label: Text('Title')),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    List<DataRow> output = [];
    for (int i = 0; i < count; i++) {
      output.add(DataRow(cells: [
        DataCell(Text(bookList[i].isbn.toString()), onTap: () {
          _navigateToMod(context, 'Edit Book', bookList[i]);
        }),
        DataCell(Text(bookList[i].author), onTap: () {
          _navigateToMod(context, 'Edit Book', bookList[i]);
        }),
        DataCell(Text(bookList[i].title), onTap: () {
          _navigateToMod(context, 'Edit Book', bookList[i]);
        })
      ]));
    }
    return output;
  }

  _navigateToMod(BuildContext context, String appBarTitle, Book book) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookMod(appBarTitle, book);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Book>> bookListFuture = databaseHelper.getBookList();
      bookListFuture.then((bookList) {
        setState(() {
          this.bookList = bookList;
          count = bookList.length;
        });
      });
    });
  }
}
