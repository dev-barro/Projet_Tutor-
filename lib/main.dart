import 'package:application/MyNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          MyNavigationBar(), // Utilisez la classe de votre barre de navigation comme page d'accueil
    );
  }
}
