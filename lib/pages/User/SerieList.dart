import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class ListeSeriesPage extends StatefulWidget {
  @override
  _ListeSeriesPageState createState() => _ListeSeriesPageState();
}

class _ListeSeriesPageState extends State<ListeSeriesPage> {
  late Future<List<Serie>> _seriesFuture;

  @override
  void initState() {
    super.initState();
    _loadSeries();
  }

  Future<void> _loadSeries() async {
    setState(() {
      _seriesFuture = DatabaseHelper.getSerie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des séries'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Serie>>(
        future: _seriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune série trouvée'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final serie = snapshot.data![index];
                return ListTile(
                  title: Text(serie.nom),
                  // Vous pouvez ajouter d'autres détails de la série ici
                );
              },
            );
          }
        },
      ),
    );
  }
}
