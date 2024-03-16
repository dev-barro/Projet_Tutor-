import 'package:application/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  // declaration d'un espace pour stocker l'index de la page actuelle
  int _currentIndex = 0;
  // la methode permetant de modifier la l'index de ma page
  setCurrentIndex(int index) {
    // on met à jour l'interface avec setState
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "CampusOrientApp",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 15, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
        body: const HomePage(),
        // debut de la creation des boutons de navigation
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // propriétée indique la page courante

          onTap: (index) => setCurrentIndex(
              index), //cette propriété va me permettre de changer de page lorsque clique sur les boutton de navaigation
          // coloration d'item selection  en couleur verte
          selectedItemColor: Colors.green,
          // coloration d'item non selection en couleur noire
          unselectedItemColor: Colors.black,
          elevation: 3,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit_sharp), label: 'formations'),
          ],
        ),
        //fin de la creation  des bouttons de la navigation
      ),
    );
  }
}
/*
*/
