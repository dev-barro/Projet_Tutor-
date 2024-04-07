// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:application/pages/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<List<University>> universitiesFuture;

  @override
  void initState() {
    super.initState();
    universitiesFuture = UniversityDataBase.instance.getAllUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes universités'),
      ),
      body: FutureBuilder<List<University>>(
        future: universitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Une erreur s\'est produite.'));
          } else if (snapshot.hasData) {
            List<University>? universities = snapshot.data;
            if (universities != null && universities.isNotEmpty) {
              return ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university = universities[index];
                  return Dismissible(
                    key: Key(university.name!),
                    onDismissed: (direction) {
                      setState(() {
                        universities.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${university.name} supprimé."),
                      ));
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(university.name!),
                      subtitle: Text(university.type!),
                      trailing: Text(university.ville! ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Aucune université trouvée.'));
            }
          } else {
            return const Center(child: Text('Aucune donnée disponible.'));
          }
        },
      ),
    );
  }
}
