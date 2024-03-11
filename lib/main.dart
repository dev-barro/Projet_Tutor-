import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("OrientaApp"),
            ),
            body: const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " OrientaApp",
                  style: TextStyle(fontSize: 24,
                   fontFamily: 'Poppins'),
                ),
                Text(
                  "L'Appli guide pour reussir son orientation poste secondaire",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )
              ],
            ))));
  }
}
