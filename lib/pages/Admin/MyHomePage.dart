import 'package:flutter/material.dart';
import 'package:application/pages/Admin/InsertDebouche.dart';
import 'package:application/pages/Admin/InsertFilierePage.dart';
import 'package:application/pages/Admin/InsertOptionPage.dart';
import 'package:application/pages/Admin/InsertSerieFiliere.dart';
import 'package:application/pages/Admin/InsertSeriePage.dart';
import 'package:application/pages/Admin/InsertUFRPage.dart';
import 'package:application/pages/InsertUniversitePage.dart';
import 'package:application/pages/User/FiliereList.Dart';
import 'package:application/pages/User/IESListPage.dart';
import 'package:application/pages/User/SerieList.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false, // Supprime le bandeau "debug"
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    RedirectionPage(),
    AddIESForm(),
    InsertUFRPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'IES',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'UFR',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class RedirectionPage extends StatelessWidget {
  const RedirectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redirections'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (int result) {
              // Handle the menu selection here
              print('Selected: $result');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Option 1'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Option 2'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Option 3'),
              ),
            ],
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIESForm()),
                );
              },
              child: const Text('Inserer Une Université '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertUFRPage()),
                );
              },
              child: const Text(' Inserser une UFR'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertFiliereForm()),
                );
              },
              child: const Text(' Inserer une filières'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertOptionForm()),
                );
              },
              child: const Text('Ajouter une option '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertDeboucheForm()),
                );
              },
              child: const Text('Ajouter un debouché '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSerieForm()),
                );
              },
              child: const Text('Ajouter des serie '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SerieFiliereForm()),
                );
              },
              child: const Text('Etablir une relation Serie-Filiere '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FiliereListPage()),
                );
              },
              child: const Text('Voir mes filières  '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeSeriesPage()),
                );
              },
              child: const Text('Voir les types de series  '),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IESListPage(
                          'Les universités de formation au Burkina Faso')),
                );
              },
              child: const Text('Trouver Une Filière'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color color;

  const CustomIcon(
      {Key? key,
      required this.iconData,
      this.size = 24.0,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}

class RedirectionScreen extends StatelessWidget {
  final String pageTitle;

  const RedirectionScreen(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Retour'),
        ),
      ),
    );
  }
}
