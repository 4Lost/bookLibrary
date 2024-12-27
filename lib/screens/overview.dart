import 'package:book_library/screens/book/book_view.dart';
import 'package:book_library/screens/reads/read_view.dart';
import 'package:book_library/screens/records/record_view.dart';
import 'package:book_library/screens/shelf/shelf_view.dart';
import 'package:book_library/utils/database_helper.dart';
import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  String path;
  late DatabaseHelper helper;

  OverView({super.key, required this.path}) {
    helper = DatabaseHelper(path);
  }

  // TODO: Layout verschönern,
  // TODO: Add path to forwards

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$path'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Books
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Books',
                    textScaler: TextScaler.linear(1.5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookView(path: path),
                      ),
                    );
                  },
                ),
                // Shelfs
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Shelfs',
                    textScaler: TextScaler.linear(1.5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ShelfView();
                        },
                      ),
                    );
                  },
                ),
                // Reads
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Reads',
                    textScaler: TextScaler.linear(1.5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ReadView();
                        },
                      ),
                    );
                  },
                ),
                // Records
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Records',
                    textScaler: TextScaler.linear(1.5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const RecordView();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          helper.close();
          Navigator.pop(context, true);
        },
        tooltip: 'Logout',
        child: const Text('x'),
      ),
    );
  }
}
