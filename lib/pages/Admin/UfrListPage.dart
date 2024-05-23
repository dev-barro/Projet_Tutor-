import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class ListeUFRPage extends StatefulWidget {
  @override
  _ListeUFRPageState createState() => _ListeUFRPageState();
}

class _ListeUFRPageState extends State<ListeUFRPage> {
  late Future<List<Map<String, dynamic>>> ufrListFuture;

  @override
  void initState() {
    super.initState();
    ufrListFuture = DatabaseHelper.getUFR();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des UFR'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ufrListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erreur: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Map<String, dynamic>> ufrList = snapshot.data!;

              return ListView.builder(
                itemCount: ufrList.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(ufrList[index]['nom'])
                      // Vous pouvez ajouter d'autres informations de l'UFR ici
                      );
                },
              );
            } else {
              return Center(
                child: Text('Aucun UFR trouvé.'),
              );
            }
          },
        ),
      ),
    );
  }
}
