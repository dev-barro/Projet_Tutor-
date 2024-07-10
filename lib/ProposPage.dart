import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProposPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos'),
        backgroundColor: const Color.fromARGB(255, 76, 175, 142),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "À propos de notre application",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Bienvenue dans notre application mobile d'aide à l'orientation !",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Notre application est conçue pour aider les étudiants à trouver leur voie en fonction de leurs intérêts, compétences et aspirations professionnelles. Nous offrons une variété de fonctionnalités pour faciliter ce processus :",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Fonctionnalités principales :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              BulletPoint(
                  text: "Exploration des filières et des cursus disponibles."),
              BulletPoint(
                  text: "Recherche par université, UFR, série, et plus."),
              BulletPoint(
                  text: "Accès aux détails des cours et des programmes."),
              BulletPoint(
                  text:
                      "Guides et conseils pour l'orientation professionnelle."),
              BulletPoint(text: "Contact direct avec les établissements."),
              SizedBox(height: 16),
              Text(
                "Objectifs :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Notre objectif est de fournir une plateforme intuitive et accessible qui permet aux étudiants de faire des choix éclairés concernant leur avenir académique et professionnel. Nous nous efforçons de :",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              BulletPoint(
                  text:
                      "Simplifier le processus de recherche et de comparaison des filières."),
              BulletPoint(
                  text:
                      "Offrir des informations précises et à jour sur les programmes."),
              BulletPoint(
                  text:
                      "Aider les étudiants à trouver des programmes qui correspondent à leurs intérêts et compétences."),
              BulletPoint(
                  text:
                      "Faciliter la communication entre les étudiants et les établissements."),
              SizedBox(height: 16),
              Text(
                "Nous espérons que notre application vous sera utile dans votre parcours académique et professionnel. N'hésitez pas à nous contacter pour toute question ou suggestion !",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Contactez-nous :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _launchURL('mailto:barrodramane910@gmail.com'),
                child: Text(
                  "Email : barrodramane910@gmail.com",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
              InkWell(
                onTap: () => _launchURL('tel:+226 74170325/62111810'),
                child: Text(
                  "Téléphone : +226 74170325/62111810",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
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

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "• ",
          style: TextStyle(fontSize: 18),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
