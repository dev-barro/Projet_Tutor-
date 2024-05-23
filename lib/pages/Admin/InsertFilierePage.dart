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

  int _selectedUFRId = 0;
  int _selectedIESId = 0;

  List<Map<String, dynamic>> _iesList = [];
  List<Map<String, dynamic>> _ufrList = [];

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _matieresDominantesController = TextEditingController();
    _matieresImportantesController = TextEditingController();
    _conditionsParticulieresController = TextEditingController();
    _infoComplementaireController = TextEditingController();
    _coutDeLaFormationController = TextEditingController();
    _loadData();
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

  Future<void> _loadData() async {
    _iesList = await DatabaseHelper.getIES();
    _ufrList = await DatabaseHelper.getUFR();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une filière'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'Nom de la filière'),
            ),
            TextField(
              controller: _matieresDominantesController,
              decoration: InputDecoration(labelText: 'Matieres Dominantes'),
            ),
            TextField(
              controller: _matieresImportantesController,
              decoration: InputDecoration(
                  labelText: 'Matieres Importantes De Laterminale'),
            ),
            TextField(
              controller: _conditionsParticulieresController,
              decoration:
                  InputDecoration(labelText: 'Conditions Particulieres'),
            ),
            TextField(
              controller: _infoComplementaireController,
              decoration:
                  InputDecoration(labelText: 'Info Complementaire (optionnel)'),
            ),
            TextField(
              controller: _coutDeLaFormationController,
              decoration: InputDecoration(
                  labelText: 'Cout de la Formation (optionnel)'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedIESId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedIESId = newValue ?? 0;
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
            ),
            DropdownButtonFormField<int>(
              value: _selectedUFRId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedUFRId = newValue ?? 0;
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
            ),
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
                  iesId: _selectedIESId,
                  ufrId: _selectedUFRId,
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
                  content: Text('Filière ajoutée avec succès'),
                ));
              },
              child: Text('Ajouter la filière'),
            ),
          ],
        ),
      ),
    );
  }
}
