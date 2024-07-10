import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  const BackgroundImageWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with blur effect
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 200,
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
