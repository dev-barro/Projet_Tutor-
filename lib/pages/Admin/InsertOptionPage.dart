import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class InsertOptionForm extends StatefulWidget {
  @override
  _InsertOptionFormState createState() => _InsertOptionFormState();
}

class _InsertOptionFormState extends State<InsertOptionForm> {
  late TextEditingController _nameController;
  late TextEditingController _anneeDeOptionController;
  late int _selectedFiliereId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _anneeDeOptionController = TextEditingController();
    _selectedFiliereId = 0; // Valeur initiale
  }

  @override
  void dispose() {
    _nameController.dispose();
    _anneeDeOptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom de l\'option'),
            ),
            TextField(
              controller: _anneeDeOptionController,
              decoration: InputDecoration(labelText: 'Année de l\'option'),
            ),
            DropdownButtonFormField<int>(
              value: _selectedFiliereId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedFiliereId = newValue ?? 0;
                });
              },
              items: [], // Remplissez cette liste avec les filières disponibles depuis la base de données
              decoration: InputDecoration(labelText: 'Sélectionner une filière'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Création de l'option à partir des données du formulaire...
                Options newOption = Options(
                  id: 0, // L'ID sera automatiquement généré dans la base de données
                  name: _nameController.text,
                  anneeDeOption: _anneeDeOptionController.text,
                  filiereId: _selectedFiliereId,
                );

                // Appel de la méthode pour insérer l'option dans la base de données...
                await DatabaseHelper.insertOptions(newOption);

                // Réinitialisation des champs après l'insertion réussie
                _nameController.clear();
                _anneeDeOptionController.clear();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Option ajoutée avec succès'),
                ));
              },
              child: Text('Ajouter l\'option'),
            ),
          ],
        ),
      ),
    );
  }
}
