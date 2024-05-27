import 'package:flutter/material.dart';
import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';

class FiliereDetailsPage extends StatefulWidget {
  final Filiere filiere;

  FiliereDetailsPage({required this.filiere});

  @override
  _FiliereDetailsPageState createState() => _FiliereDetailsPageState();
}

class _FiliereDetailsPageState extends State<FiliereDetailsPage> {
   late Future<String?> _iesNameFuture;
  late Future<List<Serie>> _seriesFuture;
  late Future<String?> _ufrNameFuture;
  @override
  void initState() {
    super.initState();
     _iesNameFuture = DatabaseHelper.getIESNameById(widget.filiere.iesId);
    _seriesFuture = DatabaseHelper.getSeriesForFiliere(widget.filiere.id);
_ufrNameFuture = DatabaseHelper.getUFRNameById(widget.filiere.ufrId);  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la filière'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom de la filière: ${widget.filiere.nom}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Matieres Dominantes: ${widget.filiere.matieresDominantes}'),
            SizedBox(height: 10),
            Text('Matieres Importantes: ${widget.filiere.matieresImportantesDeLaterminale}'),
            SizedBox(height: 10),
            Text('Conditions Particulières: ${widget.filiere.conditionsParticulieres}'),
            SizedBox(height: 10),
            Text('Coût de la Formation: ${widget.filiere.coutDeLaFormation ?? "N/A"}'),
            SizedBox(height: 10),
            Text('Informations Complémentaires: ${widget.filiere.infoComplementaire ?? "N/A"}'),
            SizedBox(height: 20),
            Text(
              'Options:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Options>>(
              future: DatabaseHelper.getOptionsForFiliere(widget.filiere.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Options> options = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: options
                        .map((option) => Text('- ${option.name}, Année: ${option.anneeDeOption ?? "N/A"}'))
                        .toList(),
                  );
                } else {
                  return Text('Aucune option trouvée');
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Débouchés:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Debouche>>(
              future: DatabaseHelper.getDebouchesForFiliere(widget.filiere.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Debouche> debouches = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: debouches
                        .map((debouche) => Text('- ${debouche.description}'))
                        .toList(),
                  );
                } else {
                  return Text('Aucun débouché trouvé');
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Informations sur l\'IES associé:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          
            SizedBox(height: 20),
            Text(
              'Informations sur l\'IES associé:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<String?>(
              future: _iesNameFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Nom de l\'IES: ${snapshot.data ?? "Non trouvé"}');
                } else {
                  return Text('Informations sur l\'IES non trouvées');
                }
              },
            ),

            SizedBox(height: 20),
            Text(
              'UFR:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<String?>(
              future: _ufrNameFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Nom de l\'UFR: ${snapshot.data ?? "Non trouvé"}');
                } else {
                  return Text('Informations sur l\'UFR non trouvées');
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Séries:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Serie>>(
              future: _seriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Une erreur est survenue: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<Serie> series = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: series
                        .map((serie) => Text('- ${serie.nom}'))
                        .toList(),
                  );
                } else {
                  return Text('Aucune série trouvée');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
