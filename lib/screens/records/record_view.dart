import 'package:book_library/models/records.dart';
import 'package:book_library/screens/records/record_mod.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

// TODO: fix dummy path

class RecordView extends StatefulWidget {
  const RecordView({super.key});

  @override
  State<StatefulWidget> createState() {
    return RecordViewState();
  }
}

class RecordViewState extends State<RecordView> {
  DatabaseHelper databaseHelper = DatabaseHelper('');
  List<Records> recordList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    updateListView();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Records'),
        ),
        body: Center(
            child: ListView(children: [
          _createDataTable(context),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToMod(context, 'Add Record', Records('', ''));
          },
          tooltip: 'Add Record',
          child: const Text('+'),
        ));
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ISBN')),
      const DataColumn(label: Text('Comment')),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    List<DataRow> output = [];
    for (int i = 0; i < count; i++) {
      output.add(DataRow(cells: [
        DataCell(Text(recordList[i].isbn), onTap: () {
          _navigateToMod(context, 'Edit Record', recordList[i]);
        }),
        DataCell(Text(recordList[i].comment), onTap: () {
          _navigateToMod(context, 'Edit Record', recordList[i]);
        })
      ]));
    }
    return output;
  }

  _navigateToMod(BuildContext context, String appBarTitle, Records record) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecordMod(appBarTitle, record);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Records>> recordListFuture = databaseHelper.getRecordList();
      recordListFuture.then((recordList) {
        setState(() {
          this.recordList = recordList;
          count = recordList.length;
        });
      });
    });
  }
}
