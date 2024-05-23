import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class FiliereListPage extends StatefulWidget {
  @override
  _FiliereListPageState createState() => _FiliereListPageState();
}

class _FiliereListPageState extends State<FiliereListPage> {
  late Future<List<Filiere>> _filieresFuture;

  @override
  void initState() {
    super.initState();
    _filieresFuture = DatabaseHelper.getAllFilieres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Filières'),
      ),
      body: FutureBuilder<List<Filiere>>(
        future: _filieresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune filière trouvée.'));
          } else if (snapshot.hasData) {
            List<Filiere> filieres = snapshot.data!;
            return ListView.builder(
              itemCount: filieres.length,
              itemBuilder: (context, index) {
                Filiere filiere = filieres[index];
                return ListTile(
                  title: Text(filiere.nom),
                  subtitle: Text('matieresDominantes: ${filiere.matieresDominantes}'),
                  // Affichez d'autres informations de la filière si nécessaire
                );
              },
            );
          } else {
            return Container(); // Cas par défaut
          }
        },
      ),
    );
  }
}
