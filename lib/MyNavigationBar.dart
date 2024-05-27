import 'package:flutter/material.dart';
import 'package:application/HomePage.dart';
import 'package:application/IESPage.dart';
import 'package:application/ProfilPage.dart';
import 'package:application/ContactsPage.dart';
import 'package:application/ParametrePage.dart';
import 'package:application/FilieresPage.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FilieresPage(),
    IESPage(),
    ProfilPage(),
  ];
  final List<String> _appBarTitles = [
    "Accueil",
    "Filières",
    "IES",
    "Profil",
  ];

  final List<String> _drawerItems = [
    "Rechercher une filière",
    "Trouver une université",
    "Profil",
    "À propos",
    "Contacts",
    "Paramètre",
    "Fermer",
  ];

  final List<IconData> _drawerIcons = [
    Icons.layers,
    Icons.school,
    Icons.person,
    Icons.info_rounded,
    Icons.contact_page_sharp,
    Icons.settings_applications,
    Icons.close,
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Si l'index correspond à Accueil, ouvrir le tiroir de navigation
    if (index == 0) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_currentIndex]),
        backgroundColor: Color.fromARGB(255, 76, 175, 142),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(237, 255, 255, 255),
              ),
              child: Text('MENU'),
            ),
            for (var i = 0; i < _drawerItems.length; i++)
              ListTile(
                leading: Icon(
                    _drawerIcons[i]), // Ajouter l'icône à l'élément du tiroir
                title: Text(_drawerItems[i]),
                onTap: () {},
              ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white54,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavigationBarItem(
                icon: Icons.home,
                label: "Accueil",
                index: 0,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.layers,
                label: "Trouver Une filière",
                index: 1,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.school,
                label: "Trouver Une IES",
                index: 2,
              ),
              _buildBottomNavigationBarItem(
                icon: Icons.person,
                label: "Connaitre mon profil",
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isSelected ? Colors.green : Colors.black87, size: 32),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.green,
                fontSize: isSelected ? 20 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
