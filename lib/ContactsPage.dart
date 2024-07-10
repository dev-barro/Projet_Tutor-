import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: const Color.fromARGB(255, 76, 175, 142),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nous contacter",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Vous pouvez nous contacter pour toute question ou suggestion concernant l'application. Voici comment nous joindre :",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Email :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _launchURL('mailto:support@orientationapp.com'),
                child: Text(
                  "support@orientationapp.com",
                  style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Téléphone :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _launchURL('tel:+123456789'),
                child: Text(
                  "+123 456 789",
                  style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Adresse :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "123 Rue de l'Orientation\n75000 Paris, France",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
