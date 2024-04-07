import 'package:application/pages/universityList.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:application/pages/ModelsTable.dart';
// import 'package:application/pages/database_helper.dart';

void main() async {
  // Initialise la fabrique de base de données avec sqflite_common
  DatabaseFactory? databaseFactoryFfi;
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universités',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}
