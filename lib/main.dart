import 'package:flutter/material.dart';
import 'dart:ui'; // Pour utiliser ImageFilter

void main() => runApp(MyLAO());

class MyLAO extends StatefulWidget {
  const MyLAO({super.key});

  @override
  State<MyLAO> createState() => _MyLAOState();
}

class _MyLAOState extends State<MyLAO> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExamplePage(),
    ProfilePage(),
    AProposPage(),
    ContactsPage(),
    ParametrePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("LAO BF 2024"),
          backgroundColor: Colors.green,
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
                  icon: Icons.person,
                  label: "Profil",
                  index: 2,
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.info_outline,
                  label: "A propos",
                  index: 3,
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.contact_page,
                  label: "Contact",
                  index: 4,
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.settings_accessibility_outlined,
                  label: "Paramètre",
                  index: 5,
                ),
              ],
            ),
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
                color: isSelected ? Colors.yellow : Colors.green,
                fontSize: isSelected ? 20 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  const BackgroundImageWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with blur effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drap.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Content of the page
        child,
      ],
    );
  }
}

// Example pages using the background image
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Ouvre le drawer
              },
            );
          },
        ),
      ),
      body: BackgroundImageWidget(
        child: Center(
          child: Text(
            "Home Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("Example Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("Profile Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class AProposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("A Propos Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("Contacts Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ParametrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("Parametre Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
