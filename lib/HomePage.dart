import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       // Background image with blur effect
      Positioned.fill(
        child: ColorFiltered(
        colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
          BlendMode.dstATop,
           ),
          child: SizedBox(
             width: double.infinity,
           height: 300,
            child: Image.asset(
               'assets/images/drap.png',
             fit: BoxFit.cover,
           ),
           ),
           ),
        ),
        //Contenu de la page
      ],
    );
  }
}
