import 'package:application/FilieresPage.dart';
import 'package:application/HomePage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configuration de l'animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Rediriger vers la page d'accueil après l'animation
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(fit: StackFit.expand, children: [
        Image.asset(
          'assets/images/drapbf1.png', // Chemin de votre image
          fit: BoxFit.cover, // Couvrir tout l'écran
        ),
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'Bienvenue sur LAO',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.blue,
            )
          ]),
        )
      ],
    );
  }
}
