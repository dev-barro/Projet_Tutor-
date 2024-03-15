
import 'package:application/pages/event_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CampusOrientApp"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        // la couleur du fond de page
        color: Colors.green,

        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //insertion de l'image comme le logo de l'appli
          Image.asset("assets/images/drapbf1.png"),
          const Text(
            "CampusOrientApp",
            style: TextStyle(fontSize: 32, fontFamily: ('Poppins')),
          ),
          const Text(
            "OrientaApp 2024 est l'Appli guide parfait pour reussir son orientation universitaire ",
            //definir la taille du fichier
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          //le padding pour ecarter le bouton au text
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton.icon(
            // donner une couleur au button
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => EventPage()));
            },
            label: const Text("offre de Formations"),
            icon: Icon(Icons.accessibility_outlined),
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),

          ElevatedButton.icon(
            // donner une couleur au button
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => EventPage()));
            },
            label: const Text(" voir les debouchées"),
            icon: Icon(Icons.accessibility_outlined),
          ),

          Padding(padding: EdgeInsets.only(top: 5)),
          ElevatedButton.icon(
            // donner une couleur au button
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (_, __, ___) => EventPage()));
            },
            label: const Text("CampusOrientaApp ???"),
            icon: Icon(Icons.accessibility_outlined),
          ),
        ]),
      ),
    );
  }
}