import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final events = [
    {"nom": "UNZ", "intitule": "universite publique", "avatar": "FlutterLogo"},
    {"nom": "ujkz", "intitule": "universite publique", "avatar": "FlutterLogo"},
    {
      "nom": "Nazi boni",
      "intitule": "universite publique",
      "avatar": "FlutterLogo"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final nom = event['nom'];
          final intitule = event['intitule'];
          final avatar = event['avatar'];
          return Card(
            child: ListTile(
              leading: const FlutterLogo(
                size: 50.0,
              ),
              title: Text('$nom'),
              subtitle: Text('$intitule'),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
    );
  }
}

    /*Scaffold(
      appBar: AppBar(
        title:
            const Text("La liste des universités disponibles au burkina faso"),
      ),*/