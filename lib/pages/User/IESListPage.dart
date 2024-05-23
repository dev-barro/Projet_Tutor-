import 'package:flutter/material.dart';
import 'package:application/pages/database_helper.dart';

class IESListPage extends StatelessWidget {
  final String pageTitle;

  IESListPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper.getIES(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
            ),
            body: Center(child: Text('Une erreur est survenue')),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final iesList = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: iesList.length,
                    itemBuilder: (context, index) {
                      final ies = iesList[index];
                      return Card(
                        child: ListTile(
                          title: Text(ies['nom']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type: ${ies['type']}'),
                              Text('Ville: ${ies['ville']}'),
                              Text(
                                  'Site web: ${ies['siteWeb'] ?? 'Non disponible'}'),
                              Text(
                                  'Adresse mail: ${ies['adrMail'] ?? 'Non disponible'}'),
                              Text(
                                  'Boîte postale: ${ies['bp'] ?? 'Non disponible'}'),
                              Text(
                                  'Téléphone: ${ies['tel'] ?? 'Non disponible'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retour'),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
            ),
            body: Center(child: Text('Aucune donnée disponible')),
          );
        }
      },
    );
  }
}
