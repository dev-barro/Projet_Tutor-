import 'dart:math';
import 'package:application/ModelTable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilieresPage extends StatefulWidget {
  @override
  _FilieresPageState createState() => _FilieresPageState();
}

class _FilieresPageState extends State<FilieresPage> {
  late Future<List<Map<String, dynamic>>> _filieresFuture;
  String _searchQuery = '';
  String _selectedSerie = 'Tous';
  List<String> _series = [];

  final _random = Random();

  @override
  void initState() {
    super.initState();
    _filieresFuture = getFilieres();
  }

  Future<List<Map<String, dynamic>>> getFilieres() async {
    List<Map<String, dynamic>> filieres = [];
    Set<String> seriesSet = {};

    try {
      QuerySnapshot universitesSnapshot =
          await FirebaseFirestore.instance.collection('universites').get();

      for (var universiteDoc in universitesSnapshot.docs) {
        QuerySnapshot ufrsSnapshot = await FirebaseFirestore.instance
            .collection('universites')
            .doc(universiteDoc.id)
            .collection('ufrs')
            .get();

        for (var ufrDoc in ufrsSnapshot.docs) {
          QuerySnapshot filieresSnapshot = await FirebaseFirestore.instance
              .collection('universites')
              .doc(universiteDoc.id)
              .collection('ufrs')
              .doc(ufrDoc.id)
              .collection('Filieres')
              .get();

          for (var filiereDoc in filieresSnapshot.docs) {
            Filiere filiere = Filiere.fromMap(
                filiereDoc.data() as Map<String, dynamic>, filiereDoc.id);

            QuerySnapshot seriesSnapshot = await FirebaseFirestore.instance
                .collection('universites')
                .doc(universiteDoc.id)
                .collection('ufrs')
                .doc(ufrDoc.id)
                .collection('Filieres')
                .doc(filiereDoc.id)
                .collection('Serie')
                .get();

            for (var serieDoc in seriesSnapshot.docs) {
              seriesSet.add(serieDoc['nom']);
            }

            filieres.add({
              'filiere': filiere,
              'universiteId': universiteDoc.id,
              'ufrId': ufrDoc.id,
              'series': seriesSnapshot.docs
                  .map((doc) =>
                      Serie.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                  .toList(),
            });
          }
        }
      }
    } catch (e) {
      print('Error retrieving filieres: $e');
    }

    setState(() {
      _series = ['Tous', ...seriesSet];
    });

    return filieres;
  }

  Color randomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  IconData randomIcon() {
    List<IconData> icons = [
      Icons.school,
      Icons.account_balance,
      Icons.business,
      Icons.science,
      Icons.settings,
      Icons.computer,
      Icons.engineering,
      Icons.healing,
      Icons.language,
      Icons.public,
    ];
    return icons[_random.nextInt(icons.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/15.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher une filière...',
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[400]!, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Veuillez sélectionner une série',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 1,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedSerie,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSerie = newValue!;
                          });
                        },
                        items: _series
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _filieresFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erreur: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('Aucune filière trouvée.'));
                    } else {
                      List<Map<String, dynamic>> filteredFilieres =
                          snapshot.data!.where((filiereData) {
                        Filiere filiere = filiereData['filiere'];
                        List<Serie> series = filiereData['series'];
                        bool matchesSerie = _selectedSerie == 'Tous' ||
                            series.any((serie) => serie.nom == _selectedSerie);
                        bool matchesQuery = filiere.nom
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                        return matchesSerie && matchesQuery;
                      }).toList();

                      return ListView.builder(
                        itemCount: filteredFilieres.length,
                        itemBuilder: (context, index) {
                          var filiereData = filteredFilieres[index];
                          Filiere filiere = filiereData['filiere'];
                          String universiteId = filiereData['universiteId'];
                          String ufrId = filiereData['ufrId'];

                          return Card(
                            color: randomColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FiliereDetailPage(
                                      filiere: filiere,
                                      universiteId: universiteId,
                                      ufrId: ufrId,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(8.0), // Adjust padding
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(randomIcon(),
                                        size: 40, color: Colors.white),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        filiere.nom,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FiliereDetailPage extends StatelessWidget {
  final Filiere filiere;
  final String universiteId;
  final String ufrId;

  FiliereDetailPage(
      {required this.filiere, required this.universiteId, required this.ufrId});

  Future<Map<String, dynamic>> fetchData() async {
    String universiteNom = '';
    String ufrNom = '';
    List<Option> options = [];
    List<Serie> series = [];

    try {
      DocumentSnapshot universiteDoc = await FirebaseFirestore.instance
          .collection('universites')
          .doc(universiteId)
          .get();
      universiteNom = universiteDoc['nom'] ?? '';

      DocumentSnapshot ufrDoc = await FirebaseFirestore.instance
          .collection('universites')
          .doc(universiteId)
          .collection('ufrs')
          .doc(ufrId)
          .get();
      ufrNom = ufrDoc['nom'] ?? '';

      QuerySnapshot optionsSnapshot = await FirebaseFirestore.instance
          .collection('universites')
          .doc(universiteId)
          .collection('ufrs')
          .doc(ufrId)
          .collection('Filieres')
          .doc(filiere.id)
          .collection('Options')
          .get();
      options = optionsSnapshot.docs
          .map((doc) =>
              Option.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      QuerySnapshot seriesSnapshot = await FirebaseFirestore.instance
          .collection('universites')
          .doc(universiteId)
          .collection('ufrs')
          .doc(ufrId)
          .collection('Filieres')
          .doc(filiere.id)
          .collection('Serie')
          .get();
      series = seriesSnapshot.docs
          .map((doc) =>
              Serie.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error retrieving data: $e');
    }

    return {
      'universiteNom': universiteNom,
      'ufrNom': ufrNom,
      'options': options,
      'series': series,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Filière'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Aucune information trouvée.'));
          } else {
            String universiteNom = snapshot.data!['universiteNom'] ?? '';
            String ufrNom = snapshot.data!['ufrNom'] ?? '';
            List<Option> options =
                (snapshot.data!['options'] as List<dynamic>).cast<Option>();
            List<Serie> series =
                (snapshot.data!['series'] as List<dynamic>).cast<Serie>();

            return SingleChildScrollView(
              // Make the content scrollable
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nom: ${filiere.nom}', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Université: $universiteNom',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('UFR: $ufrNom', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    if (filiere.matieresDominantes != null)
                      Text('Matières dominantes: ${filiere.matieresDominantes}',
                          style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    if (filiere.matieresImportantesDeLaTle != null)
                      Text(
                          'Matières importantes de la Terminale: ${filiere.matieresImportantesDeLaTle}',
                          style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    if (filiere.accessibilite != null)
                      Text('Accessibilité: ${filiere.accessibilite}',
                          style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    if (filiere.contrainte != null)
                      Text('Contraintes: ${filiere.contrainte}',
                          style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    if (filiere.informationComplementaire != null)
                      Text(
                          'Informations complémentaires: ${filiere.informationComplementaire}',
                          style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Text('Options:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options
                          .map((option) =>
                              Text(option.nom, style: TextStyle(fontSize: 16)))
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Séries:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: series
                          .map((serie) =>
                              Text(serie.nom, style: TextStyle(fontSize: 16)))
                          .toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
