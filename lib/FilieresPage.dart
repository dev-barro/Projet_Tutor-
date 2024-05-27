import 'package:application/FiliereDetailsPage.dart';
import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class FilieresPage extends StatefulWidget {
  @override
  _FilieresPageState createState() => _FilieresPageState();
}

class _FilieresPageState extends State<FilieresPage> {
  List<Map<String, dynamic>> universites = [];
  List<Map<String, dynamic>> ufrs = [];
  List<Map<String, dynamic>> series = [];
  List<Filiere> filieres = [];
  List<Filiere> filteredFilieres = [];

  String? selectedUniversite;
  String? selectedUFR;
  String? selectedSerie;
  List<Map<String, dynamic>> serieFilieres = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    final universitesData = await DatabaseHelper.getIES();
    final ufrsData = await DatabaseHelper.getUFR();
    final seriesData = await DatabaseHelper.getSerie();
    final filieresData = await DatabaseHelper.getAllFilieres();
    final serieFilieresData =
        await DatabaseHelper.getAllSerieFilieresWithNames();

    setState(() {
      universites = universitesData;
      ufrs = ufrsData;
      series = seriesData
          .map((serie) => {'id': serie.id, 'nom': serie.nom})
          .toList();
      filieres = filieresData;
      serieFilieres = serieFilieresData;
    });
  }

  void applyFilters() {
    setState(() {
      filteredFilieres = filieres.where((filiere) {
        bool matchesUniversite = selectedUniversite == null ||
            universites.any((universite) =>
                universite['nom'] == selectedUniversite &&
                universite['id'] == filiere.iesId);
        bool matchesUFR = selectedUFR == null ||
            ufrs.any((ufr) =>
                ufr['nom'] == selectedUFR && ufr['id'] == filiere.ufrId);
        bool matchesSerie = selectedSerie == null ||
            serieFilieres.any((relation) =>
                relation['serieNom'] == selectedSerie &&
                relation['filiereNom'] == filiere.nom);

        return matchesUniversite && matchesUFR && matchesSerie;
      }).toList();
    });
  }

  void navigateToFiliereDetails(Filiere filiere) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiliereDetailsPage(filiere: filiere),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filières'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Universités:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: universites.isNotEmpty
                  ? DropdownButton<String>(
                      isExpanded: true,
                      items: universites.map((data) {
                        return DropdownMenuItem<String>(
                          value: data['nom'] as String,
                          child: Text(data['nom'] as String),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUniversite = newValue;
                        });
                      },
                      value: selectedUniversite,
                      hint: Text('Sélectionnez une université'),
                    )
                  : Text('Aucune université disponible'),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'UFRs:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ufrs.isNotEmpty
                  ? DropdownButton<String>(
                      isExpanded: true,
                      items: ufrs.map((data) {
                        return DropdownMenuItem<String>(
                          value: data['nom'] as String,
                          child: Text(data['nom'] as String),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUFR = newValue;
                        });
                      },
                      value: selectedUFR,
                      hint: Text('Sélectionnez un UFR'),
                    )
                  : Text('Aucun UFR disponible'),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Séries:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: series.isNotEmpty
                  ? DropdownButton<String>(
                      isExpanded: true,
                      items: series.map((data) {
                        return DropdownMenuItem<String>(
                          value: data['nom'] as String,
                          child: Text(data['nom'] as String),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSerie = newValue;
                        });
                      },
                      value: selectedSerie,
                      hint: Text('Sélectionnez une série'),
                    )
                  : Text('Aucune série disponible'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  applyFilters();
                },
                child: Text('Rechercher'),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Filières:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            filteredFilieres.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredFilieres.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredFilieres[index].nom),
                        onTap: () {
                          navigateToFiliereDetails(filteredFilieres[index]);
                        },
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Aucune filière disponible'),
                  ),
          ],
        ),
      ),
    );
  }
}
