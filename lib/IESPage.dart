import 'package:application/BackgroundImageWidget.dart';
import 'package:application/pages/Admin/ModelsTable.dart';
import 'package:application/pages/database_helper.dart';
import 'package:flutter/material.dart';

class IESPage extends StatefulWidget {
  @override
  _IESPageState createState() => _IESPageState();
}

class _IESPageState extends State<IESPage> {
  List<IES> iesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIESData();
  }

  Future<void> fetchIESData() async {
    List<IES> data = await DatabaseHelper.getAllIES();
    setState(() {
      iesList = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Institutions d\'Enseignement Supérieur'),
      ),
      body: Center(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : iesList.isEmpty
                ? Center(
                    child: Text(
                      'Aucune université trouvée.',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: iesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            iesList[index].nom,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            iesList[index].type ?? 'Pas de type',
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            // Handle IES selection
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
