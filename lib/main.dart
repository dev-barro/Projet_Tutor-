// ignore_for_file: library_private_types_in_public_api

import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/ModelsTable.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DatabaseExamplePage(),
    );
  }
}

class DatabaseExamplePage extends StatefulWidget {
  const DatabaseExamplePage({super.key});

  @override
  _DatabaseExamplePageState createState() => _DatabaseExamplePageState();
}

class _DatabaseExamplePageState extends State<DatabaseExamplePage> {
  late Future<List<Universite>> universitesFuture;
  late Future<List<Filiere>> filieresFuture;
  late Future<List<Diplome>> diplomesFuture;
  late Future<List<DiplomeFiliere>> diplomesFiliereFuture;
  late Future<List<DiplomesFinCycle>> diplomesFinCycleFuture;
  late Future<List<Debouche>> debouchesFuture;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    setState(() {
      universitesFuture = DatabaseHelper.getAllUniversites();
      filieresFuture = DatabaseHelper.getAllFilieres();
      diplomesFuture = DatabaseHelper.getAllDiplomes();
      diplomesFiliereFuture = DatabaseHelper.getAllDiplomesFiliere();
      diplomesFinCycleFuture = DatabaseHelper.getAllDiplomesFinCycle();
      debouchesFuture = DatabaseHelper.getAllDebouches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Example'),
      ),
      body: Center(
        child: FutureBuilder<List<Universite>>(
          future: universitesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final universites = snapshot.data ?? [];
              return ListView.builder(
                itemCount: universites.length,
                itemBuilder: (context, index) {
                  final universite = universites[index];
                  return ListTile(
                    title: Text(universite.nom),
                    subtitle: Text(universite.adresse),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
