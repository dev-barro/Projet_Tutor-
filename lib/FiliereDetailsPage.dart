import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ModelTable.dart';

class FiliereDetailsPage extends StatelessWidget {
  final Filiere filiere;
  final String universiteId;
  final String ufrId;

  FiliereDetailsPage({
    required this.filiere,
    required this.universiteId,
    required this.ufrId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filiere.nom),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: getUniversiteAndUfrNames(universiteId, ufrId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Impossible de charger les détails'));
          } else {
            String universiteName = snapshot.data!['universiteName']!;
            String ufrName = snapshot.data!['ufrName']!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom: ${filiere.nom}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Université: $universiteName', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('UFR: $ufrName', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  if (filiere.matieresDominantes != null) Text('Matières dominantes: ${filiere.matieresDominantes}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  if (filiere.matieresImportantesDeLaTle != null) Text('Matières importantes de la Terminale: ${filiere.matieresImportantesDeLaTle}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  if (filiere.accessibilite != null) Text('Accessibilité: ${filiere.accessibilite}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  if (filiere.contrainte != null) Text('Contraintes: ${filiere.contrainte}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  if (filiere.informationComplementaire != null) Text('Informations complémentaires: ${filiere.informationComplementaire}', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, String>> getUniversiteAndUfrNames(String universiteId, String ufrId) async {
    DocumentSnapshot universiteDoc = await FirebaseFirestore.instance.collection('universites').doc(universiteId).get();
    DocumentSnapshot ufrDoc = await FirebaseFirestore.instance
        .collection('universites')
        .doc(universiteId)
        .collection('ufrs')
        .doc(ufrId)
        .get();

    String universiteName = universiteDoc['nom'];
    String ufrName = ufrDoc['nom'];

    return {
      'universiteName': universiteName,
      'ufrName': ufrName,
    };
  }
}
