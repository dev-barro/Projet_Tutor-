import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class InsertUFRPage extends StatefulWidget {
  @override
  _InsertUFRPageState createState() => _InsertUFRPageState();
}

class _InsertUFRPageState extends State<InsertUFRPage> {
  late Future<List<Map<String, dynamic>>> iesListFuture;
  int selectedIESId = 0; // L'ID de l'IES sélectionné

  @override
  void initState() {
    super.initState();
    iesListFuture = DatabaseHelper.getIES(); // Récupérer la liste des IES
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un UFR'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: iesListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Afficher une indicateur de chargement en attendant les données
            } else if (snapshot.hasError) {
              return Text(
                  'Erreur: ${snapshot.error}'); // Afficher un message d'erreur s'il y a une erreur de chargement des données
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Map<String, dynamic>> iesList = snapshot.data!;

              return InsertUFRForm(iesList: iesList);
            } else {
              return Text(
                  'Aucun IES trouvé.'); // Afficher un message si aucune donnée n'est disponible
            }
          },
        ),
      ),
    );
  }
}

class InsertUFRForm extends StatefulWidget {
  final List<Map<String, dynamic>> iesList;

  const InsertUFRForm({Key? key, required this.iesList}) : super(key: key);

  @override
  _InsertUFRFormState createState() => _InsertUFRFormState();
}

class _InsertUFRFormState extends State<InsertUFRForm> {
  late List<DropdownMenuItem<int>> _iesDropdownItems;
  late int _selectedIESId;
  late String
      _ufrName; // Ajout de la variable _ufrName pour stocker le nom de l'UFR

  @override
  void initState() {
    super.initState();
    _selectedIESId = widget.iesList.isNotEmpty ? widget.iesList[0]['id'] : 0;
    _iesDropdownItems = _buildIESDropdownItems();
    _ufrName = ''; // Initialisation du nom de l'UFR
  }

  List<DropdownMenuItem<int>> _buildIESDropdownItems() {
    return widget.iesList.map<DropdownMenuItem<int>>((ies) {
      return DropdownMenuItem<int>(
        value: ies['id'],
        child: Text(ies['nom']),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          value: _selectedIESId,
          onChanged: (int? newValue) {
            setState(() {
              _selectedIESId = newValue ?? 0;
            });
          },
          items: _iesDropdownItems,
          decoration: InputDecoration(
            labelText: 'Sélectionner un IES',
          ),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Nom de l\'UFR',
          ),
          onChanged: (value) {
            // Mettre à jour le nom de l'UFR lorsque l'utilisateur saisit
            setState(() {
              _ufrName = value;
            });
          },
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () async {
            // Vérifier si le nom de l'UFR est vide
            if (_ufrName.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Veuillez saisir le nom de l\'UFR'),
              ));
              return;
            }

            // Récupérer l'ID de l'IES sélectionné
            int selectedIESId = _selectedIESId;

            // Créer un objet UFR avec l'ID de l'IES sélectionné et le nom de l'UFR
            UFR ufr = UFR(id: 0, nom: _ufrName, iesId: selectedIESId);

            try {
              // Insérer l'UFR dans la base de données en utilisant DatabaseHelper
              await DatabaseHelper.insertUFR(ufr);

              // Afficher une boîte de dialogue ou une notification pour indiquer que l'UFR a été ajouté avec succès
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$_ufrName ajouté avec succès"),
              ));
            } catch (e) {
              // En cas d'erreur lors de l'insertion de l'UFR, afficher un message d'erreur
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Erreur lors de l\'ajout de l\'UFR: $e'),
              ));
            }
          },
          child: Text('Ajouter'),
        ),
      ],
    );
  }
}
