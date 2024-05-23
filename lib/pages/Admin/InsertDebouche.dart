import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class InsertDeboucheForm extends StatefulWidget {
  @override
  _InsertDeboucheFormState createState() => _InsertDeboucheFormState();
}

class _InsertDeboucheFormState extends State<InsertDeboucheForm> {
  late TextEditingController _descriptionController;
  late int _selectedFiliereId;
  int? _selectedOptionId;
  List<Filiere>? _filieres;
  List<Options>? _options;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _selectedFiliereId = 0;
    _selectedOptionId = null;
    _loadData();
  }

  Future<void> _loadData() async {
    _filieres = await DatabaseHelper.getAllFilieres();
    _options = await DatabaseHelper.getOptions();
    setState(() {}); // Mise à jour de l'état du widget après le chargement des données
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un débouché'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description du débouché'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedFiliereId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedFiliereId = newValue ?? 0;
                });
              },
              items: _filieres?.map((filiere) {
                return DropdownMenuItem<int>(
                  value: filiere.id,
                  child: Text(filiere.nom),
                );
              }).toList() ?? [],
              decoration: InputDecoration(labelText: 'Sélectionner une filière'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedOptionId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedOptionId = newValue;
                });
              },
              items: _options?.map((option) {
                return DropdownMenuItem<int>(
                  value: option.id,
                  child: Text(option.name),
                );
              }).toList() ?? [],
              decoration: InputDecoration(labelText: 'Sélectionner une option (facultatif)'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Création du débouché à partir des données du formulaire...
                Debouche newDebouche = Debouche(
                  id: 0, // L'ID sera automatiquement généré dans la base de données
                  description: _descriptionController.text,
                  filiereId: _selectedFiliereId,
                  optionId: _selectedOptionId,
                );

                // Appel de la méthode pour insérer le débouché dans la base de données...
                await DatabaseHelper.insertDebouche(newDebouche);

                // Réinitialisation des champs après l'insertion réussie
                _descriptionController.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Débouché ajouté avec succès'),
                ));
              },
              child: Text('Ajouter le débouché'),
            ),
          ],
        ),
      ),
    );
  }
}
