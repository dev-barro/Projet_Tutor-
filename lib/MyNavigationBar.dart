import 'package:application/ContactsPage.dart';
import 'package:application/FilieresPage.dart';
import 'package:application/ListeDeFiliere.dart';
import 'package:application/ProposPage.dart';
import 'package:flutter/material.dart';
import 'package:application/HomePage.dart';
import 'package:application/IESPage.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    HomePage(),
    FilieresPage(),
    const UniversiteListPage(),
  ];
  final List<String> _appBarTitles = [
    "Accueil",
    "Filières",
    "IES",
  ];

  final List<String> _drawerItems = [
    "À propos",
    "Contacts",
    "Fermer",
  ];

  final List<IconData> _drawerIcons = [
    Icons.info_rounded,
    Icons.contact_page_sharp,
    Icons.close,
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _appBarTitles[_currentIndex],
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 175, 142),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.yellow),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Color.fromARGB(255, 23, 150, 122)),
                child: Text(
                  'MENU',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              for (var i = 0; i < _drawerItems.length; i++)
                ListTile(
                  leading: Icon(
                    _drawerIcons[i],
                    color: Colors.black,
                  ),
                  title: Text(_drawerItems[i]),
                  onTap: () {
                    Navigator.pop(context); // Fermer le tiroir
                    if (_drawerItems[i] == 'À propos') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProposPage()),
                      );
                    } else if (_drawerItems[i] == 'Contacts') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactsPage()),
                      );
                    } else if (_drawerItems[i] == 'Fermer') {
                      Navigator.pop(context);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: _buildBottomNavigationBarItem(
                icon: Icons.home,
                label: "Accueil",
                index: 0,
              ),
            ),
            Expanded(
              child: _buildBottomNavigationBarItem(
                icon: Icons.layers,
                label: "Filières",
                index: 1,
              ),
            ),
            Expanded(
              child: _buildBottomNavigationBarItem(
                icon: Icons.school,
                label: "IES",
                index: 2,
              ),
            ),
          ],
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
