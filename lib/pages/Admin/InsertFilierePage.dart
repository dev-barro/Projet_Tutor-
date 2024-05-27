import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class InsertFiliereForm extends StatefulWidget {
  @override
  _InsertFiliereFormState createState() => _InsertFiliereFormState();
}

class _InsertFiliereFormState extends State<InsertFiliereForm> {
  late TextEditingController _nomController;
  late TextEditingController _matieresDominantesController;
  late TextEditingController _matieresImportantesController;
  late TextEditingController _conditionsParticulieresController;
  late TextEditingController _infoComplementaireController;
  late TextEditingController _coutDeLaFormationController;

  int? _selectedUFRId;
  int? _selectedIESId;

  Future<List<Map<String, dynamic>>>? _iesFuture;
  Future<List<Map<String, dynamic>>>? _ufrFuture;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _matieresDominantesController = TextEditingController();
    _matieresImportantesController = TextEditingController();
    _conditionsParticulieresController = TextEditingController();
    _infoComplementaireController = TextEditingController();
    _coutDeLaFormationController = TextEditingController();

    _iesFuture = DatabaseHelper.getIES();
    _ufrFuture = DatabaseHelper.getUFR();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _matieresDominantesController.dispose();
    _matieresImportantesController.dispose();
    _conditionsParticulieresController.dispose();
    _infoComplementaireController.dispose();
    _coutDeLaFormationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une filière'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom de la filière'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _matieresDominantesController,
                decoration: InputDecoration(labelText: 'Matieres Dominantes'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _matieresImportantesController,
                decoration: InputDecoration(
                    labelText: 'Matieres Importantes De Laterminale'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _conditionsParticulieresController,
                decoration:
                    InputDecoration(labelText: 'Conditions Particulieres'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _infoComplementaireController,
                decoration: InputDecoration(
                    labelText: 'Info Complementaire (optionnel)'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _coutDeLaFormationController,
                decoration:
                    InputDecoration(labelText: 'Cout de la Formation (optionnel)'),
              ),
              SizedBox(height: 16.0),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _iesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur lors du chargement des IES');
                  } else if (snapshot.hasData) {
                    var _iesList = snapshot.data!;
                    if (_iesList.isEmpty) {
                      return Text('Aucun IES trouvé.');
                    }
                    return DropdownButtonFormField<int>(
                      value: _selectedIESId,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedIESId = newValue ?? _iesList[0]['id'];
                        });
                      },
                      items: _iesList
                          .map<DropdownMenuItem<int>>((Map<String, dynamic> ies) {
                        return DropdownMenuItem<int>(
                          value: ies['id'],
                          child: Text(ies['nom']),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Sélectionner une IES'),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 16.0),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _ufrFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur lors du chargement des UFR');
                  } else if (snapshot.hasData) {
                    var _ufrList = snapshot.data!;
                    if (_ufrList.isEmpty) {
                      return Text('Aucun UFR trouvé.');
                    }
                    return DropdownButtonFormField<int>(
                      value: _selectedUFRId,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedUFRId = newValue ?? _ufrList[0]['id'];
                        });
                      },
                      items: _ufrList
                          .map<DropdownMenuItem<int>>((Map<String, dynamic> ufr) {
                        return DropdownMenuItem<int>(
                          value: ufr['id'],
                          child: Text(ufr['nom']),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Sélectionner un UFR'),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Création de la filière à partir des données du formulaire...
                  Filiere nouvelleFiliere = Filiere(
                    id: 0, // Mettez la valeur appropriée pour l'ID de la filière
                    nom: _nomController.text,
                    matieresDominantes: _matieresDominantesController.text,
                    matieresImportantesDeLaterminale:
                        _matieresImportantesController.text,
                    conditionsParticulieres:
                        _conditionsParticulieresController.text,
                    iesId: _selectedIESId!,
                    ufrId: _selectedUFRId!,
                    coutDeLaFormation:
                        _coutDeLaFormationController.text.isNotEmpty
                            ? _coutDeLaFormationController.text
                            : null,
                    infoComplementaire:
                        _infoComplementaireController.text.isNotEmpty
                            ? _infoComplementaireController.text
                            : null,
                  );
                  // Appel de la méthode pour insérer la filière dans la base de données...
                  await DatabaseHelper.insertFiliere(nouvelleFiliere);
                  // Réinitialisation des champs après l'insertion réussie
                  _nomController.clear();
                  _matieresDominantesController.clear();
                  _matieresImportantesController.clear();
                  _conditionsParticulieresController.clear();
                  _infoComplementaireController.clear();
                  _coutDeLaFormationController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Filière "${nouvelleFiliere.nom}" ajoutée avec succès'),
                  ));
                },
                child: Text('Ajouter la filière'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
