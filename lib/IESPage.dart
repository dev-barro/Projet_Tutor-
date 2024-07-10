import 'package:application/ListesDesUfrs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UniversiteListPage extends StatefulWidget {
  const UniversiteListPage({Key? key}) : super(key: key);

  @override
  _UniversiteListPageState createState() => _UniversiteListPageState();
}

class _UniversiteListPageState extends State<UniversiteListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _universitesStream;
  String _selectedType = 'Tous';

  @override
  void initState() {
    super.initState();
    _universitesStream = _getUniversitesStream();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _selectedType = 'Tous';
          break;
        case 1:
          _selectedType = 'PUBLIC';
          break;
        case 2:
          _selectedType = 'PRIVE';
          break;
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _getUniversitesStream() {
    return FirebaseFirestore.instance.collection('universites').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Tous'),
            Tab(text: 'Public'),
            Tab(text: 'Privé'),
          ],
        ),
      ),
      body: 
      Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/15.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _universitesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<DocumentSnapshot<Map<String, dynamic>>> universiteDocs =
                    snapshot.data!.docs;

                if (_selectedType != 'Tous') {
                  universiteDocs = universiteDocs.where((universite) {
                    return universite['type'] == _selectedType;
                  }).toList();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: universiteDocs.length,
                  itemBuilder: (context, index) {
                    String nomUniversite = universiteDocs[index]['nom'] as String;
                    return _buildUniversiteCard(universiteDocs[index], nomUniversite);
                  },
                );
              },
            ),
          ),
        ],
      ),
  ]),);
  }

  Widget _buildUniversiteCard(DocumentSnapshot<Map<String, dynamic>> universiteDoc, String nomUniversite) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(nomUniversite,style: TextStyle(color: Colors.orange),),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UfrListPage(universiteId: universiteDoc.id),
            ),
          );
        },
      ),
    );
  }
}
