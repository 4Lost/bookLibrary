import 'package:book_library/models/shelf.dart';
import 'package:book_library/screens/shelf/shelf_mod.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

// TODO: fix dummy path

class ShelfView extends StatefulWidget {
  const ShelfView({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShelfViewState();
  }
}

class ShelfViewState extends State<ShelfView> {
  DatabaseHelper databaseHelper = DatabaseHelper('');
  List<Shelf> shelfList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    updateListView();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Shelfs'),
        ),
        body: Center(
            child: ListView(children: [
          _createDataTable(context),
        ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _navigateToMod(context, 'Add Shelf', Shelf('', '', '', '', ''));
          },
          tooltip: 'Add Shelf',
          child: const Text('+'),
        ));
  }

  DataTable _createDataTable(BuildContext context) {
    return DataTable(columns: _createColumns(), rows: _createRows(context));
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('ISBN')),
      const DataColumn(label: Text('Place')),
      const DataColumn(label: Text('Shelf')),
      const DataColumn(label: Text('Board')),
      const DataColumn(label: Text('Spot')),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    List<DataRow> output = [];
    for (int i = 0; i < count; i++) {
      output.add(DataRow(cells: [
        DataCell(Text(shelfList[i].isbn), onTap: () {
          _navigateToMod(context, 'Edit Shelf', shelfList[i]);
        }),
        DataCell(Text(shelfList[i].place), onTap: () {
          _navigateToMod(context, 'Edit Shelf', shelfList[i]);
        }),
        DataCell(Text(shelfList[i].shelf), onTap: () {
          _navigateToMod(context, 'Edit Shelf', shelfList[i]);
        }),
        DataCell(Text(shelfList[i].board), onTap: () {
          _navigateToMod(context, 'Edit Shelf', shelfList[i]);
        }),
        DataCell(Text(shelfList[i].spot), onTap: () {
          _navigateToMod(context, 'Edit Shelf', shelfList[i]);
        })
      ]));
    }
    return output;
  }

  _navigateToMod(BuildContext context, String appBarTitle, Shelf shelf) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShelfMod(appBarTitle, shelf);
    }));
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Shelf>> shelfListFuture = databaseHelper.getShelfList();
      shelfListFuture.then((shelfList) {
        setState(() {
          this.shelfList = shelfList;
          count = shelfList.length;
        });
      });
    });
  }
}
