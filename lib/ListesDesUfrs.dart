import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UfrListPage extends StatelessWidget {
  final String universiteId;

  const UfrListPage({Key? key, required this.universiteId}) : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>> _getUfrsStream() {
    return FirebaseFirestore.instance
        .collection('universites')
        .doc(universiteId)
        .collection('ufrs')
        .snapshots();
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des UFRs'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _getUfrsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot<Map<String, dynamic>>> ufrDocs =
              snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: ufrDocs.length,
            itemBuilder: (context, index) {
              String ufrId = ufrDocs[index].id;
              String nomUfr = ufrDocs[index]['nom'] as String;

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: randomColor(), // Couleur aléatoire pour la carte
                child: ListTile(
                  title: Text(nomUfr),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FiliereListPage(
                          universiteId: universiteId,
                          ufrId: ufrId,
                          nomUfr: nomUfr,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FiliereListPage extends StatelessWidget {
  final String universiteId;
  final String ufrId;
  final String nomUfr;

  const FiliereListPage(
      {Key? key,
      required this.universiteId,
      required this.ufrId,
      required this.nomUfr})
      : super(key: key);

  Stream<QuerySnapshot<Map<String, dynamic>>> _getFilieresStream() {
    return FirebaseFirestore.instance
        .collection('universites')
        .doc(universiteId)
        .collection('ufrs')
        .doc(ufrId)
        .collection('Filieres')
        .snapshots();
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Filières'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _getFilieresStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot<Map<String, dynamic>>> filiereDocs =
              snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filiereDocs.length,
            itemBuilder: (context, index) {
              String filiereId = filiereDocs[index].id;
              String nomFiliere = filiereDocs[index]['nom'] as String;

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: randomColor(), // Couleur aléatoire pour la carte
                child: ListTile(
                  title: Text(nomFiliere),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FiliereDetailPage(
                          universiteId: universiteId,
                          ufrId: ufrId,
                          filiereId: filiereId,
                          nomUfr: nomUfr,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FiliereDetailPage extends StatelessWidget {
  final String universiteId;
  final String ufrId;
  final String filiereId;
  final String nomUfr;

  const FiliereDetailPage(
      {Key? key,
      required this.universiteId,
      required this.ufrId,
      required this.filiereId,
      required this.nomUfr})
      : super(key: key);

  Future<Map<String, dynamic>> _getUniversiteAndFiliereData() async {
    DocumentSnapshot<Map<String, dynamic>> universiteDoc =
        await FirebaseFirestore.instance
            .collection('universites')
            .doc(universiteId)
            .get();

    DocumentSnapshot<Map<String, dynamic>> filiereDoc = await FirebaseFirestore
        .instance
        .collection('universites')
        .doc(universiteId)
        .collection('ufrs')
        .doc(ufrId)
        .collection('Filieres')
        .doc(filiereId)
        .get();

    QuerySnapshot<Map<String, dynamic>> seriesQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('universites')
            .doc(universiteId)
            .collection('ufrs')
            .doc(ufrId)
            .collection('Filieres')
            .doc(filiereId)
            .collection('Serie')
            .get();

    QuerySnapshot<Map<String, dynamic>> optionsQuerySnapshot =
        await FirebaseFirestore.instance
            .collection('universites')
            .doc(universiteId)
            .collection('ufrs')
            .doc(ufrId)
            .collection('Filieres')
            .doc(filiereId)
            .collection('Options')
            .get();

    List<Map<String, dynamic>> seriesList =
        seriesQuerySnapshot.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> optionsList =
        optionsQuerySnapshot.docs.map((doc) => doc.data()).toList();

    return {
      'universiteNom': universiteDoc['nom'],
      'filiereData': filiereDoc.data(),
      'seriesList': seriesList,
      'optionsList': optionsList,
    };
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Filière'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUniversiteAndFiliereData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!['filiereData'] == null) {
            return Center(child: Text('Filière non trouvée'));
          }

          var filiereData =
              snapshot.data!['filiereData'] as Map<String, dynamic>;
          String nomUniversite = snapshot.data!['universiteNom'] as String;
          String nomFiliere = filiereData['nom'] as String;
          String matieresDominantes =
              filiereData['matieresDominantes'] as String;
          String matieresImportantesDeLaTle =
              filiereData['matieresImportantesDeLaTle'] as String;
          String accessibilite = filiereData['accessibilite'] as String;
          String informationComplementaire =
              filiereData['informationComplementaire'] as String;

          List<Map<String, dynamic>> seriesList =
              snapshot.data!['seriesList'] as List<Map<String, dynamic>>;
          List<Map<String, dynamic>> optionsList =
              snapshot.data!['optionsList'] as List<Map<String, dynamic>>;

         return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue, Colors.green],
                      ),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nomFiliere, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 8),
                        Text('UNIVERSITE: $nomUniversite', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        Text('UFR: $nomUfr', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 16),
                  Text('Matieres Dominantes: $matieresDominantes', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Matieres Importantes de la Tle: $matieresImportantesDeLaTle',style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Accessibilité: $accessibilite',style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Information Complémentaire: $informationComplementaire',style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Séries:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Container(
                    height: 100, // Hauteur fixe pour les séries horizontales
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: seriesList
                          .map((serie) => Card(
                                color:
                                    randomColor(), // Couleur aléatoire pour la carte
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(serie['nom'] as String,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('options:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ...optionsList
                      .map((options) => ListTile(
                            title: Text(options['nom'] as String),
                            tileColor:
                                randomColor(), // Couleur aléatoire pour la tuile de liste
                          ))
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
