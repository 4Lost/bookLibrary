import 'package:book_library/screens/accountManagement/login_view.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const HomeScreenApp());
}

class HomeScreenApp extends StatelessWidget {
  const HomeScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LoginView(),
    );
  }
}
