import 'package:book_library/models/read.dart';
import 'package:book_library/screens/reads/read_mod.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ReadView extends StatefulWidget {
  const ReadView({super.key});

  @override
  State<StatefulWidget> createState() {
    return ReadViewState();
  }
}

class ReadViewState extends State<ReadView> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Read> readList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    updateListView();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reads'),
        ),
        body: Center(
            child: ListView(children: [
          _createDataTable(context),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToMod(context, 'Add Read', Read('', ''));
          },
          tooltip: 'Add Read',
          child: const Text('+'),
        ));
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ISBN')),
      const DataColumn(label: Text('Date')),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    List<DataRow> output = [];
    for (int i = 0; i < count; i++) {
      output.add(DataRow(cells: [
        DataCell(Text(readList[i].isbn), onTap: () {
          _navigateToMod(context, 'Edit Read', readList[i]);
        }),
        DataCell(Text(readList[i].date), onTap: () {
          _navigateToMod(context, 'Edit Read', readList[i]);
        })
      ]));
    }
    return output;
  }

  _navigateToMod(BuildContext context, String appBarTitle, Read read) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReadMod(appBarTitle, read);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Read>> readListFuture = databaseHelper.getReadList();
      readListFuture.then((readList) {
        setState(() {
          this.readList = readList;
          count = readList.length;
        });
      });
    });
  }
}
