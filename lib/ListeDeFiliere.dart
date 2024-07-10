// import 'dart:math';
// import 'package:application/FiliereDetailsPage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FiliereListPage extends StatefulWidget {
//   const FiliereListPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FiliereListPageState createState() => _FiliereListPageState();
// }

// class _FiliereListPageState extends State<FiliereListPage> {
//   late Stream<QuerySnapshot<Map<String, dynamic>>> _filieresStream;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchText = '';

//   @override
//   void initState() {
//     super.initState();
//     _filieresStream = _getFilieresStream();
//   }

//   Stream<QuerySnapshot<Map<String, dynamic>>> _getFilieresStream() {
//     return FirebaseFirestore.instance.collectionGroup('Filieres').snapshots();
//   }

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.blue.withOpacity(0.1), // Couleur de fond légèrement transparente
//             borderRadius: BorderRadius.circular(10.0), // Bords arrondis
//           ),
//           child: Card(
//             elevation: 0, // Pas d'ombre
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: TextField(
//                 controller: _searchController,
//                 style: const TextStyle(color: Colors.black87),
//                 cursorColor: Colors.blue,
//                 decoration: InputDecoration(
//                   hintText: 'Rechercher une filière...',
//                   hintStyle: TextStyle(color: Colors.black54),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.black54),
//                     onPressed: () {
//                       _searchController.clear();
//                       _updateSearch('');
//                     },
//                   ),
//                   border: InputBorder.none,
//                 ),
//                 onChanged: (value) {
//                   _updateSearch(value);
//                 },
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: _buildFiliereList(),
//         ),
//       ],
//     ),
//   );
// }

//   Widget _buildFiliereList() {
//     return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//       stream: _filieresStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Erreur: ${snapshot.error}'));
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         List<DocumentSnapshot<Map<String, dynamic>>> filieresDocs =
//             snapshot.data!.docs;

//         // Filtrer les filières en fonction du texte de recherche
//         List<DocumentSnapshot<Map<String, dynamic>>> filteredFilieres = filieresDocs.where((filiere) {
//           String nomFiliere = filiere['nom'].toString().toLowerCase();
//           return nomFiliere.contains(_searchText.toLowerCase());
//         }).toList();

//         return ListView.builder(
//           padding: const EdgeInsets.all(8.0),
//           itemCount: filteredFilieres.length,
//           itemBuilder: (context, index) {
//             String nomFiliere = filteredFilieres[index]['nom'] as String;
//             Color randomColor = _getRandomColor();
//             return _buildFiliereCard(nomFiliere, randomColor);
//           },
//         );
//       },
//     );
//   }

//   void _updateSearch(String searchText) {
//     setState(() {
//       _searchText = searchText;
//     });
//   }

//   Color _getRandomColor() {
//     Random random = Random();
//     return Color.fromRGBO(
//       random.nextInt(256),
//       random.nextInt(256),
//       random.nextInt(256),
//       1,
//     );
//   }

//   Widget _buildFiliereCard(String nomFiliere, Color color) {
//   return GestureDetector(
//     onTap: () {
//       // Naviguer vers la page de détail de la filière avec les détails pertinents
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DetailFilierePage(nomFiliere: nomFiliere),
//         ),
//       );
//     },
//     child: Card(
//       color: color,
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               nomFiliere,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             // Ajoutez ici d'autres détails de la filière si nécessaire
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }
