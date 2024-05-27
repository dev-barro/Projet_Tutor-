import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class SerieFiliereForm extends StatefulWidget {
  @override
  _SerieFiliereFormState createState() => _SerieFiliereFormState();
}

class _SerieFiliereFormState extends State<SerieFiliereForm> {
  late List<Filiere> _filieres;
  late List<Serie> _series;
  int? _selectedFiliereId; // Utilisez un type nullable pour la valeur sélectionnée

  List<int> _selectedSeries = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _filieres = []; // Initialisation à une liste vide
    _series = [];
    _filieres = await DatabaseHelper.getAllFilieres();
    _series = await DatabaseHelper.getSerie();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une relation Série-Filière'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Sélectionnez une filière :'),
            DropdownButtonFormField<int>(
              value: _selectedFiliereId,
              onChanged: (int? newValue) {
                setState(() {
                  _selectedFiliereId = newValue; // Affectez directement la nouvelle valeur
                  _selectedSeries.clear(); // Réinitialiser les séries sélectionnées
                });
              },
              items: _filieres.map((filiere) {
                return DropdownMenuItem<int>(
                  value: filiere.id,
                  child: Text(filiere.nom),
                );
              }).toList(),
            ),
            Text('Sélectionnez des séries :'),
            Column(
              children: _series.map((serie) {
                return CheckboxListTile(
                  title: Text(serie.nom),
                  value: _selectedSeries.contains(serie.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedSeries.add(serie.id);
                      } else {
                        _selectedSeries.remove(serie.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_selectedFiliereId != null) {
                  for (int serieId in _selectedSeries) {
                    SerieFiliere newRelation = SerieFiliere(
                      id: 0,
                      filiereId: _selectedFiliereId!,
                      serieId: serieId,
                    );
                    await DatabaseHelper.insertSerieFiliere(newRelation);
                  }
                  _selectedSeries.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Relations ajoutées avec succès'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Veuillez sélectionner une filière'),
                  ));
                }
              },
              child: Text('Ajouter les relations'),
            ),
          ],
        ),
      ),
    );
  }
}
