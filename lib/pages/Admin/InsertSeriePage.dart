import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class AddSerieForm extends StatefulWidget {
  const AddSerieForm({Key? key}) : super(key: key);

  @override
  State<AddSerieForm> createState() => _AddSerieFormState();
}

class _AddSerieFormState extends State<AddSerieForm> {
  List<String> serieTypes = [
    'A4',
    'A5',
    'AA',
    'AGRI',
    'AUCI',
    'BC',
    'BS',
    'C',
    'CC',
    'CUI',
    'D',
    'E',
    'ES',
    'ETCH',
    'EXAMEN SPECIAL',
    'F1',
    'F2',
    'F3',
    'F4',
    'FC',
    'FCL',
    'G1',
    'G2',
    'GCC',
    'GCTP',
    'GT',
    'H',
    'MAVELEC',
    'MI',
    'MVA',
    'RESTAU',
    'TELECOM',
    'SM',
    'TVC',
    'TVO',
    'TVOE'
  ];
  List<String> selectedSeries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter des séries'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: serieTypes.length,
        itemBuilder: (context, index) {
          final serie = serieTypes[index];
          return CheckboxListTile(
            title: Text(serie),
            value: selectedSeries.contains(serie),
            onChanged: (bool? value) {
              setState(() {
                if (value!) {
                  selectedSeries.add(serie);
                } else {
                  selectedSeries.remove(serie);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertSelectedSeries();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Future<void> insertSelectedSeries() async {
    for (String serieName in selectedSeries) {
      Serie serie = Serie(id: 0, nom: serieName);
      await DatabaseHelper.insertSerie(serie);
    }
    // Afficher un message de confirmation ou effectuer d'autres actions après l'insertion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Séries ajoutées avec succès')),
    );
  }
}

 
