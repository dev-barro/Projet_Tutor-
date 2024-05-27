import 'package:application/BackgroundImageWidget.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("A Propos Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
