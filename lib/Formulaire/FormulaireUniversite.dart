// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application/ModelTable.dart';

class AjouterUniversiteForm extends StatefulWidget {
  const AjouterUniversiteForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AjouterUniversiteFormState createState() => _AjouterUniversiteFormState();
}

class _AjouterUniversiteFormState extends State<AjouterUniversiteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();
  final TextEditingController _siteWebController = TextEditingController();
  final TextEditingController _boitePostaleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Universite nouvelleUniversite = Universite(
        id: '', // L'ID sera généré par Firestore
        nom: _nomController.text,
        adresse: _adresseController.text,
        ville: _villeController.text,
        siteWeb: _siteWebController.text,
        boitePostale: _boitePostaleController.text,
        type: _typeController.text,
      );

      await FirebaseFirestore.instance.collection('universites').add(nouvelleUniversite.toMap());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Université ajoutée avec succès!')),
      );

      _resetForm();
    }
  }

  void _resetForm() {
    _nomController.clear();
    _adresseController.clear();
    _villeController.clear();
    _siteWebController.clear();
    _boitePostaleController.clear();
    _typeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Université'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'université';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _adresseController,
                decoration: const InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _villeController,
                decoration: const InputDecoration(
                  labelText: 'Ville',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _siteWebController,
                decoration: const InputDecoration(
                  labelText: 'Site Web',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.web),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _boitePostaleController,
                decoration: const InputDecoration(
                  labelText: 'Boîte Postale',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.markunread_mailbox),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le type de l\'université';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Ajouter Université'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
