import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class AddIESForm extends StatefulWidget {
  @override
  _AddIESFormState createState() => _AddIESFormState();
}

class _AddIESFormState extends State<AddIESForm> {
  // Liste des types d'IES disponibles
  List<String> iesTypes = ['PRIVE', 'PUBLIC', 'PROFESSIONNEL'];
  

  // Variable pour stocker le type sélectionné
  String? selectedType;
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _siteWebController = TextEditingController();
  final TextEditingController _adrMailController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _bpController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une IES'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
              items: iesTypes.map((String type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'nom'),
            ),
            TextField(
              controller: _siteWebController,
              decoration: InputDecoration(labelText: 'Site Web'),
            ),
            TextField(
              controller: _adrMailController,
              decoration: InputDecoration(labelText: 'Adresse Mail'),
            ),
            TextField(
              controller: _villeController,
              decoration: InputDecoration(labelText: 'Ville'),
            ),
            TextField(
              controller: _bpController,
              decoration: InputDecoration(labelText: 'Boîte Postale'),
            ),
            TextField(
              controller: _telController,
              decoration: InputDecoration(labelText: 'Téléphone'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _insertIES();
              },
              child: Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

  void _insertIES() async {
    String nom = _nomController.text.trim();
    String siteWeb = _siteWebController.text.trim();
    String adrMail = _adrMailController.text.trim();
    String ville = _villeController.text.trim();
    String bp = _bpController.text.trim();
    String tel = _telController.text.trim();

    // Créez une nouvelle instance d'IES avec les données du formulaire
    IES newIES = IES(
      id: 0, // L'ID sera généré automatiquement par la base de données
      type: selectedType!,
      nom: nom,
      siteWeb: siteWeb.isNotEmpty ? siteWeb : null,
      adrMail: adrMail.isNotEmpty ? adrMail : null,
      ville: ville,
      bp: bp.isNotEmpty ? bp : null,
      tel: tel.isNotEmpty ? tel : null,
    );

    // Insérez la nouvelle IES dans la base de données
    await DatabaseHelper.insertIES(newIES);

    // Affichez un message pour indiquer que l'opération est réussie
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('IES ajoutée avec succès')),
    );

    // Effacez les champs du formulaire après l'insertion
    _nomController.clear();
    _siteWebController.clear();
    _adrMailController.clear();
    _villeController.clear();
    _bpController.clear();
    _telController.clear();
  }
}
