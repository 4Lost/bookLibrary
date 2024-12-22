import 'package:book_library/screens/book/book_view.dart';
import 'package:flutter/material.dart';

class OverView extends StatelessWidget {
  const OverView({super.key});

  // TODO: Layout verschönern,
  // TODO: add "shelf", "read", "reacord"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const BookView();
              }));
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
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
