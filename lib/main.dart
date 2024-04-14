import 'dart:io';

import 'package:application/ListDeFiliere.dart';
import 'package:application/pages/DebouchesList.dart';
import 'package:application/pages/PageInsertion.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';
import 'package:application/pages/ModelsTable.dart';

void main() async {
  runApp(const MyApp());
  await DatabaseHelper.insertListOfUniversites(universites);
  await DatabaseHelper.insertListOfDebouches(debouches);
  await DatabaseHelper.insertListOfFiliere(filieres);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les universités de formations au Burkina Faso',
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
  // ignore: library_private_types_in_public_api
  _DatabaseExamplePageState createState() => _DatabaseExamplePageState();
}

class _DatabaseExamplePageState extends State<DatabaseExamplePage> {
  late Future<List<Universite>> universitesFuture;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    setState(() {
      universitesFuture = DatabaseHelper.getAllUniversites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Les universités de formations au Burkina Faso'),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
                  Universite universite = universites[index];
                  return ListTile(
                    title: Text(universite.nom),
                    subtitle: Text(universite.adresse),
                    leading: universite.imagePath.isNotEmpty
                        ? Image.file(File(universite
                            .imagePath)) // Charger l'image à partir du chemin d'accès
                        : const Icon(Icons
                            .image_not_supported), // Si aucun chemin d'accès n'est disponible
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
