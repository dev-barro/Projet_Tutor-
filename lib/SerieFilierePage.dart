import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class ViewRelationsPage extends StatefulWidget {
  @override
  _ViewRelationsPageState createState() => _ViewRelationsPageState();
}

class _ViewRelationsPageState extends State<ViewRelationsPage> {
  late Future<List<Map<String, dynamic>>> _relationsFuture;

  @override
  void initState() {
    super.initState();
    _relationsFuture = _loadRelations();
  }

  Future<List<Map<String, dynamic>>> _loadRelations() async {
    return await DatabaseHelper.getAllSerieFilieresWithNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voir les relations Série-Filière'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _relationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune relation trouvée'));
          } else {
            List<Map<String, dynamic>> relations = snapshot.data!;
            Map<String, List<String>> filiereSeriesMap = {};
            for (var relation in relations) {
              String filiereNom = relation['filiereNom'];
              String serieNom = relation['serieNom'];
              if (!filiereSeriesMap.containsKey(filiereNom)) {
                filiereSeriesMap[filiereNom] = [];
              }
              filiereSeriesMap[filiereNom]!.add(serieNom);
            }
            return ListView(
              children: filiereSeriesMap.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key),
                  children: entry.value.map((serieNom) {
                    return ListTile(
                      title: Text(serieNom),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
